defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    result =
      rna
      |> String.graphemes()
      |> Enum.chunk_every(3)
      |> Enum.map(fn x -> Enum.join(x) end)
      |> Enum.uniq()
      |> Enum.take_while(fn x -> x not in ~w(UAA UAG UGA) end)
      |> Enum.map(fn x -> get_codon(x) end)
      |> Enum.reject(fn x -> x == nil end)

    cond do
      String.ends_with?(rna, "ROT") -> {:error, "invalid RNA"}
      result != [] -> {:ok, result}
      true -> {:error, "invalid RNA"}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    result = codon |> get_codon

    cond do
      result -> {:ok, result}
      true -> {:error, "invalid codon"}
    end
  end

  def get_codon(codon) do
    cond do
      codon in ~w(AUG) -> "Methionine"
      codon in ~w(UUU UUC) -> "Phenylalanine"
      codon in ~w(UUA UUG) -> "Leucine"
      codon in ~w(UCU UCC UCA UCG) -> "Serine"
      codon in ~w(UAU UAC) -> "Tyrosine"
      codon in ~w(UGU UGC) -> "Cysteine"
      codon in ~w(UGG) -> "Tryptophan"
      codon in ~w(UAA UAG UGA) -> "STOP"
      true -> nil
    end
  end
end
