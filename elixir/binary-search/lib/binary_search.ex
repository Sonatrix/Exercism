defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    binary_search(numbers, key, 0, tuple_size(numbers))
  end

  defp binary_search(numbers, _key, _low, _high) when tuple_size(numbers) < 1 do
    :not_found
  end

  defp binary_search(_numbers, _key, low, high) when low > high do
    :not_found
  end

  defp binary_search(numbers, key, low, high) when tuple_size(numbers) > 0 do
    mid = div(low + high, 2)

    if mid >= tuple_size(numbers) do
      :not_found
    else
      item = elem(numbers, mid)

      cond do
        key < item -> binary_search(numbers, key, low, mid - 1)
        key > item -> binary_search(numbers, key, mid + 1, high)
        true -> {:ok, mid}
      end
    end
  end
end
