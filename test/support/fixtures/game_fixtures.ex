defmodule Ex2048.GameFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ex2048.Game`
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      Ex2048.Game.create_and_init_game()
    game
  end
end
