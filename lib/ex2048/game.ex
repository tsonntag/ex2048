defmodule Ex2048.Game do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Ex2048.{Board, Game, Repo}

  schema "games" do
    field :board, :string
    field :steps, :integer
    timestamps()
  end

  def width(%Game{board: board}), do: Board.width(board)

  def height(%Game{board: board}), do: Board.height(board)

  def init_game(), do: %Game{board: Board.init(), steps: 1}

  def done?(%Game{board: board}), do: Board.done?(board)

  def changeset(game, attrs) do
    game
    |> cast(attrs, [:board, :steps])
    |> validate_required([:board])
  end

  def list_games, do: Repo.all(Game) |> IO.inspect(label: "REPO.ALL")|> Enum.map(&decode/1)

  def get_game!(id), do: Repo.get!(Game, id) |> decode()

  def create_and_init_game()do
    init_game()
    |> encode()
    |> Repo.insert()
  end

  defp update_game(%Game{} = game, attrs) do
    { :ok, game } = game
    |> encode()
    |> Game.changeset(encode(attrs))
    |> Repo.update()

    { :ok, game |> decode() }
  end

  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  def move(%Game{board: board, steps: steps} = game, direction) do
    board = Board.move(board, direction)

    game
    |> update_game(%{board: board, steps: steps + 1})
  end

  defp encode(%{board: board} = attrs) do
    %{attrs | board: Jason.encode!(board)}
  end

  defp decode(%{board: board} = game) do
    %{game | board: Jason.decode!(board)}
  end

end
