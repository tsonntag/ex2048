defmodule Ex2048.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :board, :string
      add :steps, :integer

      timestamps()
    end
  end
end
