defmodule Md2html.Parser do
  @moduledoc """
  Handles parsing of Markdown text into structured format.
  """

  @doc """
  Parses a complete Markdown document into a list of structured elements.
  """
  def parse(markdown) when is_binary(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map(&String.trim_trailing/1)  # Preserve indentation
    |> parse_lines([], false)  # false means not in code block
    |> Enum.reverse()
    |> clean_output()
  end

  # Clean up the parsed output
  defp clean_output(elements) do
    elements
    |> Enum.filter(fn
      {:blank, _} -> false
      _ -> true
    end)
  end

  # Parse lines while tracking context
  defp parse_lines([], acc, _in_code), do: acc

  # Handle code block start
  defp parse_lines([line | rest], acc, false) when line == "```" do
    parse_lines(rest, [{:code_block_start, ""} | acc], true)
  end
  defp parse_lines(["```" <> lang | rest], acc, false) do
    parse_lines(rest, [{:code_block_start, String.trim(lang)} | acc], true)
  end

  # Handle code block end
  defp parse_lines([line | rest], acc, true) when line == "```" do
    parse_lines(rest, [{:code_block_end, ""} | acc], false)
  end

  # Handle regular lines inside code block
  defp parse_lines([line | rest], acc, true) do
    parse_lines(rest, [{:p, line} | acc], true)
  end

  # Handle regular lines outside code block
  defp parse_lines([line | rest], acc, false) do
    parse_lines(rest, [parse_line(line) | acc], false)
  end

  @doc """
  Parses a single line of Markdown text.
  """
  def parse_line("# " <> rest), do: {:h1, apply_inline(rest)}
  def parse_line("## " <> rest), do: {:h2, apply_inline(rest)}
  def parse_line("### " <> rest), do: {:h3, apply_inline(rest)}
  def parse_line("#### " <> rest), do: {:h4, apply_inline(rest)}
  def parse_line("##### " <> rest), do: {:h5, apply_inline(rest)}
  def parse_line("###### " <> rest), do: {:h6, apply_inline(rest)}

  def parse_line("- " <> rest), do: {:ul_item, apply_inline(rest)}
  def parse_line("> " <> rest), do: {:blockquote, apply_inline(rest)}
  def parse_line("---"), do: {:hr, ""}
  def parse_line(""), do: {:blank, ""}
  def parse_line(line), do: {:p, apply_inline(line)}

  @doc """
  Processes inline Markdown elements like bold, italic, and code.
  """
  def apply_inline(text) do
    text
    |> replace_bold()
    |> replace_italic()
    |> replace_code()
    |> replace_links()
  end

  # Helper functions for inline elements
  defp replace_bold(text) do
    Regex.replace(~r/\*\*(.+?)\*\*/, text, "<strong>\\1</strong>")
  end

  defp replace_italic(text) do
    Regex.replace(~r/\*(.+?)\*/, text, "<em>\\1</em>")
  end

  defp replace_code(text) do
    Regex.replace(~r/`(.+?)`/, text, "<code>\\1</code>")
  end

  defp replace_links(text) do
    Regex.replace(~r/\[(.+?)\]\((.+?)\)/, text, "<a href=\"\\2\">\\1</a>")
  end
end
