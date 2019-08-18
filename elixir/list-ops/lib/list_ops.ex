defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([_ | tail]) do
    1 + count(tail)
  end

  def count([]), do: 0

  @spec reverse(list) :: list
  def reverse(l) do
    reverse(l, [])
  end

  def reverse([head | tail], acc) do
    reverse(tail, [head | acc])
  end

  def reverse([], acc), do: acc

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    for x <- l, do: f.(x)
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    for x <- l, f.(x), do: x
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([head | tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end

  def reduce([], acc, _), do: acc

  @spec append(list, list) :: list
  def append([head | tail], b) do
    [head | append(tail, b)]
  end

  def append([], b), do: b

  @spec concat([[any]]) :: [any]
  def concat([head | tail]) do
    append(head, concat(tail))
  end

  def concat([]), do: []
end
