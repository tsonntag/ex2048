defmodule Ex2048Web.GameLive.Index do
  use Ex2048Web, :live_view

  alias Ex2048.Game

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :games, list_games())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :create, _params) do
    {:ok, game} = Game.create_and_start_game()

    socket
    |> assign(:page_title, "New Game")
    |> assign(:game, game)
    |> push_redirect(to: Routes.game_show_path(socket, :show, game))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Games")
    |> assign(:game, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    game = Game.get_game!(id)
    {:ok, _} = Game.delete_game(game)

    {:noreply, assign(socket, :games, list_games())}
  end

  defp list_games do
    Game.list_games()
    |> IO.inspect(label: "INDEX list_games")
  end
end
