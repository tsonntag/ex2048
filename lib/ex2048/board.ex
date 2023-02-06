defmodule Ex2048.Board do

  import Ex2048.Utils, only: [transpose: 1]
  alias Ex2048.Row

  @type size :: {non_neg_integer(), non_neg_integer()}
  @type(direction :: :right, :left, :up, :down)
  @type board :: list(Row.t())

  @spec new(size()) :: board()
  def new(size \\ {4, 4}) do
    {width, height} = size
    pawn = nil
    Row.new(width, pawn) |> List.duplicate(height)
  end

  @spec start(size()) :: board()
  def start(size \\ {4, 4}), do: new(size) |> put_random

  @spec move(board(), direction()) :: board()
  def move(board, direction) do
    if can_shift?(board, direction) do
      board |> shift(direction) |> put_random
    else
      board
    end
  end

  @spec full?(board()) :: boolean()
  def full?(board), do: board |> empty_points |> Enum.empty?

  defp put_random(board) do
    random_point = board |> empty_points |> Enum.take_random(1) |> hd
    # use same propabilty as in https://github.com/gabrielecirulli/2048
    pawn = if Enum.random(1..10) < 10, do: 2, else: 4
    put(board, random_point, pawn)
  end

  defp can_shift?(board, direction) do
    shift(board, direction) != board
  end

  defp shift(board, :up) do
    board |> transpose |> shift(:left) |> transpose
  end

  defp shift(board, :down) do
    board |> transpose |> shift(:right) |> transpose
  end

  defp shift(board, direction) do
    Enum.map(board, &Row.shift(&1, direction))
  end

  defp get(board, {x, y}) do
    board |> Enum.at(y, []) |> Row.get(x)
  end

  defp put(board, {x, y}, pawn) do
    board |> List.update_at(y, &Row.put(&1, x, pawn))
  end

  defp row_count(board), do: length(board)

  defp points(board) do
    for x <- Row.xs(board), y <- 0..row_count(board)-1, do: {x,y}
  end

  defp empty_points(board) do
    points(board) |> Enum.filter(&!get(board, &1))
  end
end