defmodule Ex2048.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  Ex2048.Games.Board

  schema "games" do
    field :board, :string
    field :steps, :id

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

end
