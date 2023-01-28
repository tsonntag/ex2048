defmodule Ex2048.Games.Board do

  @type point :: {non_neg_integer(), non_neg_integer()}
  @type pawn :: pos_integer() | nil
  @type(direction :: :right, :left, :up, :down)
  @type t :: list(list(pawn()))

  @spec new(point()) :: t()
  def new(size \\ {4, 4}, pawn \\ nil) do
    {xsize, ysize} = size
    List.duplicate(pawn, xsize) |> List.duplicate(ysize)
  end

  @spec move(t(), direction()) :: t()
  def move(board, direction) do
    if can_shift?(board, direction) do
      next_board = board |> shift(direction) |> put_random()
      if full?(next_board), do: :finished, else: next_board
    else
      board
    end
  end

  @spec full?(t()) :: boolean()
  def full?(board), do: board |> empty_points |> Enum.empty?()

  @spec get(t(), point()) :: pawn()
  def get(board, {x, y}), do: board |> Enum.at(y, []) |> Enum.at(x)

  @spec put(t(), point(), pawn()) :: t()
  def put(board, {x, y}, pawn), do: board |> List.update_at(y, &List.replace_at(&1, x, pawn))

  @spec put_random(t()) :: t()
  def put_random(board) do
    random_point = board |> empty_points |> Enum.take_random(1) |> hd
    # same propabilty as in https://github.com/gabrielecirulli/2048
    pawn = if Enum.random(1..10) < 10, do: 2, else: 4
    put(board, random_point, pawn)
  end

  @spec shift(t(), direction()) :: t()
  def shift(board, :up),       do: board |> transpose |> shift(:left) |> transpose
  def shift(board, :down),     do: board |> transpose |> shift(:right) |> transpose
  def shift(board, direction), do: board |> Enum.map(&shift_row(&1, direction))

  @spec can_shift?(t(), direction()) :: boolean
  def can_shift?(board, :up),       do: board |> transpose |> can_shift?(:left)
  def can_shift?(board, :down),     do: board |> transpose |> can_shift?(:right)
  def can_shift?(board, direction), do: board |> Enum.any?(&can_row_shift?(&1, direction))

  defp shift_row(row, :left),  do: row |> shift_row_left  |> pad(length(row))
  defp shift_row(row, :right), do: row |> Enum.reverse() |> shift_row(:left) |> Enum.reverse()

  defp shift_row_left(row), do: row |> Enum.filter(& &1) |> do_shift_row_left
  defp do_shift_row_left([]),            do: []
  defp do_shift_row_left([nil  | rest]), do: do_shift_row_left(rest)
  defp do_shift_row_left([a, a | rest]), do: [2 * a | do_shift_row_left(rest)]
  defp do_shift_row_left([a    | rest]), do: [a     | do_shift_row_left(rest)]

  defp can_row_shift?([],              :left), do: false
  defp can_row_shift?([nil, a | _],    :left) when not is_nil(a), do: true
  defp can_row_shift?([a, a   | _],    :left) when not is_nil(a), do: true
  defp can_row_shift?([_      | rest], :left), do: can_row_shift?(rest, :left)
  defp can_row_shift?(row, :right), do: row |> Enum.reverse() |> can_row_shift?(:left)

  defp xsize([row | _]), do: length(row)
  defp ysize(board), do: length(board)
  def points(board), do: for x <- 0..xsize(board)-1, y <- 0..ysize(board)-1, do: {x,y}
  def empty_points(board), do: board |> points |> Enum.filter(&!get(board, &1))

  defp pad(row, len, pad \\ nil), do: for(i <- 0..(len - 1), do: Enum.at(row, i, pad))
  defp transpose(matrix), do: matrix |> List.zip() |> Enum.map(&Tuple.to_list/1)

  def format(board) do
    board |> Enum.map(fn row -> format_row(row) <> "\n" end) |> Enum.join("")
  end

  def dump(board), do: board |> format() |> IO.puts

  defp format_row(row), do: "|" <> (Enum.map(row, &format_cell/1) |> Enum.join("|")) <> "|"
  defp format_cell(nil), do: "     "
  defp format_cell(cell), do: :io_lib.format("~5.. B", [cell])
end
