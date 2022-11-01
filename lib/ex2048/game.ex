defmodule Ex2048.Game do

  alias Ex2048.Board
  import Enum, only: [map: 2, any?: 2, reverse: 1, take_random: 2, random: 1, at: 3, filter: 2]

  def new(xsize \\ 4, ysize \\ 4), do: Board.new(xsize, ysize, nil) |> put_random

  def move(board, direction) do
    if can_shift?(board, direction) do
      next_board = board |> shift(direction) |> put_random()
      if Board.full?(next_board), do: :finished, else: next_board
    else
      board
    end
  end

  def shift(board, :left),  do: board |> map(&shift_row(&1, :left))
  def shift(board, :right), do: board |> map(&shift_row(&1, :right))
  def shift(board, :up),    do: board |> transpose |> shift(:left)  |> transpose
  def shift(board, :down),  do: board |> transpose |> shift(:right) |> transpose

  def shift_row(row, :left),  do: row |> shift_row_left |> pad(length(row))
  def shift_row(row, :right), do: row |> reverse |> shift_row(:left) |> reverse

  def shift_row_left(row), do: row |> filter(& &1) |> do_shift_row_left

  def do_shift_row_left([]),            do: []
  def do_shift_row_left([a, a | rest]), do: [2*a | do_shift_row_left(rest)]
  def do_shift_row_left([a    | rest]), do: [a   | do_shift_row_left(rest)]

  @spec can_shift?(any, :down | :left | :right | :up) :: boolean
  def can_shift?(board, :left),  do: board |> any?(&can_shift_row_left?/1)
  def can_shift?(board, :right), do: board |> any?(fn row -> row |> reverse |> can_shift_row_left? end)
  def can_shift?(board, :up),    do: board |> transpose |> can_shift?(:left)
  def can_shift?(board, :down),  do: board |> transpose |> can_shift?(:right)

  def can_shift_row_left?([]),                do: false
  def can_shift_row_left?([nil, a | _rest]) when not is_nil(a), do: true
  def can_shift_row_left?([a, a   | _rest]) when not is_nil(a), do: true
  def can_shift_row_left?([_a     | rest]),  do: can_shift_row_left?(rest)

  def put_random(board) do
    random_point = board |> Board.empty_points |> take_random(1) |> hd
    # same propabilty as in https://github.com/gabrielecirulli/2048
    value = if random(1..10) < 10, do: 2, else: 4
    Board.put(board, random_point, value)
  end

  defp pad(row, len, pad \\ nil), do: for i <- 0..len-1, do: at(row, i, pad)

  defp transpose(matrix), do: matrix |> List.zip |> map(&Tuple.to_list/1)
end
