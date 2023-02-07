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

  @type t :: %Game{board: Board.t()}

  @spec width(t()) :: non_neg_integer
  def width(%Game{board: board}), do: Board.width(board)

  @spec height(t()) :: non_neg_integer
  def height(%Game{board: board}), do: Board.height(board)

  @spec done?(Game.t()) :: boolean
  def done?(%Game{board: board}), do: Board.done?(board)

  @spec list_games() :: list(t)
  def list_games(), do: Repo.all(Game) |> Enum.map(&decode/1)

  @spec get_game!(non_neg_integer()) :: t()
  def get_game!(id), do: Repo.get!(Game, id) |> decode()

  @spec create_and_init_game :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_and_init_game()do
    %Game{board: Board.init(), steps: 1}
    |> encode()
    |> Repo.insert()
  end

  defp changeset(game, attrs) do
    game
    |> cast(attrs, [:board, :steps])
    |> validate_required([:board])
  end


  defp update_game(%Game{} = game, attrs) do
    { :ok, game } = game
    |> encode()
    |> changeset(encode(attrs))
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
