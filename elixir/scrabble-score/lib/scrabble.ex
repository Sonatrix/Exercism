defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase()
    |> String.graphemes()
    |> Enum.map(&getScore/1)
    |> Enum.sum()
  end

  defp getScore(char) do
    cond do
      char in ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"] -> 1
      char in ["D", "G"] -> 2
      char in ["B", "C", "M", "P"] -> 3
      char in ["F", "H", "V", "W", "Y"] -> 4
      char == "K" -> 5
      char in ["J", "X"] -> 8
      char in ["Q", "Z"] -> 10
      true -> 0
    end
  end
end
