defmodule Ex2048.Console do
  alias Ex2048.{Board, Show}

  def run(size \\ {4, 4}) do
    Board.init(size) |> step
  end

  def step(:quit), do: :done

  def step(board) do
    Show.inspect(board)

    if Board.done?(board) do
      :done
    else
      cmd = read_cmd() |> IO.inspect()
      board |> execute_cmd(cmd) |> step
    end
  end

  defp execute_cmd(board, :noop), do: board
  defp execute_cmd(_,     :quit), do: :quit
  defp execute_cmd(board, direction), do: Board.move(board, direction)

  defp read_cmd, do: IO.read(:line) |> String.trim() |> key_to_cmd()

  defp key_to_cmd("h"), do: :left
  defp key_to_cmd("j"), do: :down
  defp key_to_cmd("k"), do: :up
  defp key_to_cmd("l"), do: :right
  defp key_to_cmd("q"), do: :quit
  defp key_to_cmd(_), do: :noop
end
