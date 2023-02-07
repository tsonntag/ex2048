
defmodule Ex2048.Show do

  def format(board) do
    board |> Enum.map(fn row -> format_row(row) <> "\n" end) |> Enum.join("")
  end

  def inspect(board) do
    board |> format |> IO.puts
    board
  end

  defp format_row(row) do
    "|" <> (row |> Enum.map(&format_cell/1) |> Enum.join("|")) <> "|"
  end

  defp format_cell(nil), do: "     "
  defp format_cell(cell), do: :io_lib.format("~5.. B", [cell])
end
