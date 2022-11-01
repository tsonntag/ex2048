defmodule Quicksort do

  def sort([]), do: []

  def sort([ x0 | xs ]) do
    lesser  = Enum.filter(xs, fn x -> x < x0 end)
    greater = Enum.filter(xs, fn x -> x >= x0 end)
    sort(lesser) ++ [x0] ++ sort(greater)
  end
end
