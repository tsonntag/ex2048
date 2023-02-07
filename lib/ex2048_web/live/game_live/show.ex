defmodule Ex2048Web.GameLive.Show do
  use Ex2048Web, :live_view

  alias Ex2048.Game

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :show, %{"id" => id}) do
    socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:game, Game.get_game!(id))
  end

  defp apply_action(socket, :move, %{"id" => id, "direction" => direction}) do
    {:ok, game } = Game.get_game!(id)
    |> Game.move(String.to_existing_atom(direction))

    socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:game, game)
  end

  @impl true
  def handle_event("keyup", %{"key" => "ArrowUp"}, socket), do: apply_move("up", socket)
  def handle_event("keyup", %{"key" => "ArrowLeft"}, socket), do: apply_move("left", socket)
  def handle_event("keyup", %{"key" => "ArrowRight"}, socket), do: apply_move("right", socket)
  def handle_event("keyup", %{"key" => "ArrowDown"}, socket), do: apply_move("down", socket)

  defp apply_move(direction, socket) do
    id = socket.assigns.game.id
    {:noreply, apply_action(socket, :move, %{"id" => id, "direction" => direction})}
  end

  defp visible(true), do: "visible"
  defp visible(false), do: "invisible"

  def done_visible(game), do: game |> Game.done?() |> visible()

  defp page_title(:show), do: "Show Game"
  defp page_title(:move), do: "Move"
end
