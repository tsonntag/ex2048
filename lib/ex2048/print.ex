defmodule Print do

  def format(board) do
    board |> Enum.map(fn row -> format_row(row) <> "\n" end) |> Enum.join("")
  end

  defp format_row(row), do: "|" <> (row |> Enum.map(&format_cell/1) |> Enum.join("|")) <> "|"

  defp format_cell(cell), do: if cell, do: :io_lib.format("~5.. B", [cell]), else: "     "

end
