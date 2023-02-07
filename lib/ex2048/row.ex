defmodule Ex2048.Row do

  import Ex2048.Utils, only: [pad: 2]

  @type index :: non_neg_integer()
  @type direction :: :right | :left
  @type pawn :: pos_integer() | nil
  @type t :: list(pawn())

  @spec new(non_neg_integer(), pawn()) :: t()
  def new(width \\ 4, pawn \\ nil) do
    List.duplicate(pawn, width)
  end

  @spec shift(t(), direction()) :: t()
  def shift(row, :left) do
    row |> Enum.filter(& &1) |> merge_left() |> pad(length(row))
  end

  def shift(row, :right) do
    row |> Enum.reverse |> shift(:left) |> Enum.reverse()
  end

  defp merge_left([]),            do: []
  defp merge_left([a, a | rest]), do: [2 * a | merge_left(rest)]
  defp merge_left([a    | rest]), do: [a     | merge_left(rest)]

  @spec get(t(), index()) :: pawn()
  def get(row, x), do: Enum.at(row, x)

  @spec put(t(), index(), pawn()) :: t()
  def put(row, x, pawn), do: List.replace_at(row, x, pawn)

  @spec xs(t()) :: list(index())
  def xs(row) do
    for x <- 0..length(row)-1, do: x
  end

end
