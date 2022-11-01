defmodule Ex2048.Board do

  def new(xsize, ysize, value \\ nil) do
    List.duplicate(value, xsize) |> List.duplicate(ysize)
  end

  def empty_points(board), do: board |> points |> Enum.filter(&!get(board, &1))
  def full?(board), do: board |> empty_points |> Enum.empty?()

  def get(board, [x,y]),        do: board |> Enum.at(y,[]) |> Enum.at(x)
  def put(board, [x,y], value), do: board |> List.update_at(y, &List.replace_at(&1, x, value))

  defp xsize(board), do: board |> hd |> length()
  defp ysize(board), do: length(board)

  defp points(board), do: for x <- 0..xsize(board)-1, y <- 0..ysize(board)-1, do: [x,y]

  # test only
  def new_random do
    vals = [nil, 2, 4, 8]
    Enum.map(0..4, fn _ -> Enum.map(0..3, fn _ -> Enum.random(vals) end) end)
  end
end
