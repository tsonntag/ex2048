defmodule Ex2048.Utils do
  def pad(row, len, pad \\ nil) do
    for(i <- 0..(len - 1), do: Enum.at(row, i, pad))
  end

  def transpose(matrix) do
    matrix |> List.zip |> Enum.map(&Tuple.to_list/1)
  end
end
