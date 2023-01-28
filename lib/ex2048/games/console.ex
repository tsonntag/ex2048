defmodule Ex2048.Games.Console do

  alias Ex2048.Games.Board

  def run(board \\ Board.new()) do
    Board.dump(board)
    cmd(board, read_cmd() |> IO.inspect)
  end

  def cmd(board, :noop),     do: board |> run
  def cmd(board, :quit),     do: board
  def cmd(board, :finished), do: board
  def cmd(board, direction), do: board |> Board.move(direction) |> run

  defp read_cmd, do: IO.read(:line) |> String.trim |> key_to_cmd

  defp key_to_cmd("h"), do: :left
  defp key_to_cmd("j"), do: :down
  defp key_to_cmd("k"), do: :up
  defp key_to_cmd("l"), do: :right
  defp key_to_cmd("q"), do: :quit
  defp key_to_cmd(_),   do: :noop

end
