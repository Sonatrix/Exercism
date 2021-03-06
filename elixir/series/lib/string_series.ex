defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) when size > 0 do

    series =  s 
      |> String.split("", trim: true) 
      |> Enum.chunk_every(size, 1) 
      |> Enum.filter(fn x-> length(x) == size end) 
      |> Enum.map(fn x -> Enum.join(x, "") end)

    series 
  end

  def slices(_s, size) when size <= 0 do
    []
  end
end
