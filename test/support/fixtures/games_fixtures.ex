defmodule Ex2048.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ex2048.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        state: "some state",
        steps: 42
      })
      |> Ex2048.Games.create_game()

    game
  end
end
