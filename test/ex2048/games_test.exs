defmodule Ex2048.GamesTest do
  use Ex2048.DataCase

  alias Ex2048.Games

  describe "games" do
    alias Ex2048.Games.Game

    import Ex2048.GamesFixtures

    @invalid_attrs %{state: nil, steps: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{state: "some state", steps: 42}

      assert {:ok, %Game{} = game} = Games.create_game(valid_attrs)
      assert game.state == "some state"
      assert game.steps == 42
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{state: "some updated state", steps: 43}

      assert {:ok, %Game{} = game} = Games.update_game(game, update_attrs)
      assert game.state == "some updated state"
      assert game.steps == 43
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end
end
