defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """

  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, fn x -> get_rna(x) end)
  end

  defp get_rna(input) do
    case input do
        ?G -> ?C
        ?C -> ?G
        ?T -> ?A
        ?A -> ?U
    end
  end
end
