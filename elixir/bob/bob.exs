defmodule Bob do
  def hey(input) do
    cond do
      String.trim(input) == "" -> "Fine. Be that way!"
      check_question_shout?(input) -> "Calm down, I know what I'm doing!"
      check_question?(input) -> "Sure."
      check_shout?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end
  
  defp check_question_shout?(input) do
    String.ends_with?(input, "?") && check_shout?(input)
  end

  defp check_shout?(input) do
    String.upcase(input) == input && String.upcase(input) != String.downcase(input)
  end

  defp check_question?(input) do
    String.ends_with?(input, "?")
  end
end
