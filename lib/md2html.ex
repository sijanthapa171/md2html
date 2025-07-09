defmodule Md2html do
  @moduledoc """
  Markdown to HTML converter.

  This module provides the main API for converting Markdown files to HTML.
  """

  alias Md2html.{Parser, Converter, FileIO}

  @doc """
  Converts a Markdown file to HTML.

  ## Parameters

    * `input_path` - Path to the input Markdown file
    * `output_path` - Optional path for the output HTML file. If not provided,
      uses the same name as input with .html extension.

  ## Returns

    * `{:ok, output_path}` on success
    * `{:error, reason}` on failure

  ## Examples

      iex> Md2html.convert("input.md", "output.html")
      {:ok, "output.html"}

      iex> Md2html.convert("nonexistent.md")
      {:error, "Input file does not exist: nonexistent.md"}
  """
  def convert(input_path, output_path \\ nil) do
    output_path = output_path || (input_path |> Path.rootname() |> Kernel.<>(".html"))

    with {:ok, input_path} <- FileIO.validate_input_file(input_path),
         output_path = FileIO.ensure_html_extension(output_path),
         {:ok, content} <- FileIO.read_file(input_path),
         parsed = Parser.parse(content),
         html = Converter.to_html(parsed),
         {:ok, path} <- FileIO.write_file(output_path, html) do
      {:ok, path}
    end
  end

  @doc """
  Converts a Markdown string to HTML.

  ## Parameters

    * `markdown` - The Markdown string to convert

  ## Returns

    * The generated HTML string

  ## Examples

      iex> Md2html.convert_string("# Hello")
      "<!DOCTYPE html>\\n<html>....<h1>Hello</h1>...</html>"
  """
  def convert_string(markdown) when is_binary(markdown) do
    markdown
    |> Parser.parse()
    |> Converter.to_html()
  end
end
