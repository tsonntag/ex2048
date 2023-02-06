defmodule Ex2048.Game do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Ex2048.{Board, Game, Repo, Print}

  schema "games" do
    field :board, :string
    field :steps, :id

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:board, :steps])
    |> validate_required([:board])
  end

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    Repo.all(Game)
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id) do
    Repo.get!(Game, id)
  end

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
# def create_game(attrs \\ %{}) do
#   %Game{}
#   |> Game.changeset(attrs)
#   |> Repo.insert()
# end

  def create_and_start_game()do
    %Game{board: Board.start() |> Jason.encode!, steps: 1}
    |> Game.changeset(%{})
    |> Repo.insert()
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{data: %Game{}}

  """
  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end

  def width(%Game{board: board}), do: Board.width(board)

  def height(%Game{board: board}), do: Board.height(board)

  def move(%Game{board: board, steps: steps} = game, direction) do
    board = Board.move(board, direction)
    |> IO.inspect(label: "MOVE: board")
    |> Jason.encode!()

    game
    |> Game.changeset(%{board: board, steps: steps + 1})
    |> Repo.update()
    |> IO.inspect(label: "MOVE: game")
  end

end
