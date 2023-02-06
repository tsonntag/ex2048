defmodule Ex2048Web.GameLive.Show do
  use Ex2048Web, :live_view

  alias Ex2048.Game

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id } = params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, id, params)}
  end

  defp apply_action(socket, :show, id, _params) do
    socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:game, Game.get_game!(id))
  end

  defp apply_action(socket, :move, id, %{"direction" => direction}) do
    {:ok, game } = Game.get_game!(id)
    |> Game.move(String.to_existing_atom(direction))

    socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:game, game)
  end

  defp page_title(:show), do: "Show Game"
  defp page_title(:move), do: "Move"
end
