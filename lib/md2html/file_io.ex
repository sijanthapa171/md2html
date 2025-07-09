defmodule Md2html.FileIO do
  @moduledoc """
  Handles file input/output operations for the Markdown to HTML converter.
  """

  @doc """
  Reads a Markdown file from the given path.
  Returns {:ok, content} if successful, {:error, reason} if not.
  """
  def read_file(path) do
    case File.read(path) do
      {:ok, content} -> {:ok, content}
      {:error, reason} -> {:error, "Failed to read file: #{path} (#{reason})"}
    end
  end

  @doc """
  Writes HTML content to the specified file path.
  Returns :ok if successful, {:error, reason} if not.
  """
  def write_file(path, content) do
    # Ensure the output directory exists
    path
    |> Path.dirname()
    |> File.mkdir_p()

    case File.write(path, content) do
      :ok -> {:ok, path}
      {:error, reason} -> {:error, "Failed to write file: #{path} (#{reason})"}
    end
  end

  @doc """
  Ensures the given path has a .html extension
  """
  def ensure_html_extension(path) do
    if String.ends_with?(path, ".html") do
      path
    else
      path <> ".html"
    end
  end

  @doc """
  Validates that the input file exists and has a .md extension
  """
  def validate_input_file(path) do
    cond do
      !File.exists?(path) ->
        {:error, "Input file does not exist: #{path}"}

      !String.ends_with?(path, ".md") ->
        {:error, "Input file must have .md extension: #{path}"}

      true ->
        {:ok, path}
    end
  end
end
