defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map(&process/1)
    |> Enum.join()
    |> combine
  end

  defp process(t = "#" <> _), do: enclose_with_header_tag(parse_header_md_level(t))

  defp process(t = "*" <> _), do: parse_list_md_level(t)

  defp process(t) do
    enclose_with_paragraph_tag(String.split(t))
  end

  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  defp parse_list_md_level(l) do
    text =
      l
      |> String.trim_leading("* ")
      |> String.split()
      |> join_words_with_tags

    "<li>#{text}</li>"
  end

  defp enclose_with_header_tag({hl, htl}) do
    "<h#{hl}>#{htl}</h#{hl}>"
  end

  defp enclose_with_paragraph_tag(t) do
    "<p>#{join_words_with_tags(t)}</p>"
  end

  defp join_words_with_tags(t) do
    t
    |> Enum.map(fn w -> replace_md_with_tag(w) end)
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(w) do
    w
    |> replace_prefix_md
    |> replace_suffix_md
  end

  defp replace_prefix_md(w) do
    cond do
      w =~ ~r/^#{"__"}{1}/ -> replace(w, ~r/^#{"__"}{1}/, "<strong>")
      w =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> replace(w, ~r/_/, "<em>")
      true -> w
    end
  end

  defp replace_suffix_md(w) do
    cond do
      w =~ ~r/#{"__"}{1}$/ -> replace(w, ~r/#{"__"}{1}$/, "</strong>")
      w =~ ~r/[^#{"_"}{1}]/ -> replace(w, ~r/_/, "</em>")
      true -> w
    end
  end

  defp combine(l) do
    l
    |> replace("<li>", "<ul>" <> "<li>")
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end

  defp replace(text, rtext, atext, global \\ false) do
    String.replace(text, rtext, atext, global: global)
  end
end
