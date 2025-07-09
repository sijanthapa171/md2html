defmodule Mix.Tasks.Md2html do
  use Mix.Task
  alias Md2html.{Parser, Converter, FileIO}

  @shortdoc "Converts Markdown files to HTML"

  @moduledoc """
  Converts a Markdown file to HTML.

  ## Usage

      mix md2html input.md [output.html]

  If output file is not specified, it will use the same name as input with .html extension.
  """

  @impl Mix.Task
  def run(args) do
    case parse_args(args) do
      {:ok, input, output} ->
        process_file(input, output)

      {:error, message} ->
        Mix.shell().error(message)
        System.halt(1)
    end
  end

  defp parse_args([input | rest]) do
    output = case rest do
      [output | _] -> output
      [] -> input |> Path.rootname() |> Kernel.<>(".html")
    end

    {:ok, input, output}
  end

  defp parse_args([]) do
    {:error, """
    Usage: mix md2html input.md [output.html]

    Please provide an input Markdown file.
    """}
  end

  defp process_file(input, output) do
    with {:ok, input} <- FileIO.validate_input_file(input),
         output = FileIO.ensure_html_extension(output),
         {:ok, content} <- FileIO.read_file(input),
         parsed = Parser.parse(content),
         html = Converter.to_html(parsed),
         {:ok, path} <- FileIO.write_file(output, html) do
      Mix.shell().info("Successfully converted #{input} to #{path}")
    else
      {:error, message} ->
        Mix.shell().error(message)
        System.halt(1)
    end
  end
end
