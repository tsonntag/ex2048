defmodule Ex2048.Console do
  alias Ex2048.{Board, Print}

  def run(size \\ {4, 4}) do
    Board.start(size) |> step
  end

  def step(:quit), do: :done

  def step(board) do
    Print.dump(board)

    if Board.full?(board) do
      :done
    else
      cmd = read_cmd() |> IO.inspect
      board |> execute_cmd(cmd) |> step
    end
  end

  def execute_cmd(board, :noop), do: board
  def execute_cmd(_, :quit), do: :quit
  def execute_cmd(board, direction), do: Board.move(board, direction)

  defp read_cmd, do: IO.read(:line) |> String.trim() |> key_to_cmd

  defp key_to_cmd("h"), do: :left
  defp key_to_cmd("j"), do: :down
  defp key_to_cmd("k"), do: :up
  defp key_to_cmd("l"), do: :right
  defp key_to_cmd("q"), do: :quit
  defp key_to_cmd(_), do: :noop
end
