defmodule Ex2048.Board do

  import Ex2048.Utils, only: [transpose: 1]
  alias Ex2048.Row

  @type size :: {non_neg_integer(), non_neg_integer()}
  @type direction :: :left | :right | :up | :down
  @type t :: list(Row.t())

  @directions [:left, :right, :up, :down]

  @spec new(size()) :: t()
  def new(size \\ {4, 4}) do
    {width, height} = size
    pawn = nil
    Row.new(width, pawn) |> List.duplicate(height)
  end

  @spec init(size()) :: t()
  def init(size \\ {4, 4}), do: new(size) |> put_random()

  @spec move(t(), direction()) :: t()
  def move(board, direction) do
    if can_shift?(board, direction) do
      board |> shift(direction) |> put_random()
    else
      board
    end
  end

  @spec done?(t()) :: boolean()
  def done?(board) do
    !Enum.any?(@directions, &can_shift?(board, &1))
  end

  @spec height(t()) :: non_neg_integer()
  def height(board), do: length(board)

  @spec width(t()) :: non_neg_integer()
  def width([row | _]), do: length(row)

  defp put_random(board) do
    random_point = board |> empty_points() |> Enum.take_random(1) |> hd
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
    board |> Enum.map(&Row.shift(&1, direction))
  end

  defp get(board, {x, y}) do
    board |> Enum.at(y, []) |> Row.get(x)
  end

  defp put(board, {x, y}, pawn) do
    board |> List.update_at(y, &Row.put(&1, x, pawn))
  end

  defp points(board) do
    for x <- Row.xs(board), y <- 0..height(board)-1, do: {x,y}
  end

  defp empty_points(board) do
    board |> points() |> Enum.filter(&!get(board, &1))
  end

end
