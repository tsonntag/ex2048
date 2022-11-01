defmodule Ex2048.Console do

  alias Ex2028.{Game,Print}
  require Print

  def init, do: Game.new

  def run(board \\ init()) do
    print(board)
    cmd(board, read_cmd() |> IO.inspect)
  end

  def cmd(board, :noop),     do: board |> run
  def cmd(board, :quit),     do: board
  def cmd(board, :finished), do: board
  def cmd(board, direction), do: board |> Game.move(direction) |> run

  defp read_cmd, do: IO.read(:line) |> String.trim |> key_to_cmd

  defp key_to_cmd("h"), do: :left
  defp key_to_cmd("j"), do: :down
  defp key_to_cmd("k"), do: :up
  defp key_to_cmd("l"), do: :right
  defp key_to_cmd("q"), do: :quit
  defp key_to_cmd(_),   do: :noop

  defp print(board), do: board |> Print.format |> IO.puts

end
