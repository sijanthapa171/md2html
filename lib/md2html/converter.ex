defmodule Md2html.Converter do
  @moduledoc """
  Converts parsed Markdown elements into HTML.
  """

  @doc """
  Converts a list of parsed Markdown elements into a complete HTML document.
  """
  def to_html(elements) do
    content = elements
    |> process_elements()
    |> Enum.join("\n")

    """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Markdown to HTML</title>
        <style>
            body {
                max-width: 800px;
                margin: 40px auto;
                padding: 0 20px;
                font-family: -apple-system, system-ui, sans-serif;
                line-height: 1.6;
            }
            code {
                background: #f4f4f4;
                padding: 2px 5px;
                border-radius: 3px;
            }
            pre {
                background: #f4f4f4;
                padding: 1em;
                overflow-x: auto;
                border-radius: 5px;
            }
            blockquote {
                border-left: 4px solid #ccc;
                margin: 0;
                padding-left: 1em;
                color: #666;
            }
        </style>
    </head>
    <body>
    #{content}
    </body>
    </html>
    """
  end

  @doc """
  Processes a list of parsed elements into HTML strings.
  """
  def process_elements(elements) do
    elements
    |> Enum.chunk_by(fn
      {:ul_item, _} -> :list
      {:code_block_start, _} -> :code
      {:code_block_end, _} -> :code
      _ -> :other
    end)
    |> Enum.map(&process_chunk/1)
  end

  # Process different types of content chunks
  defp process_chunk([{:ul_item, _} | _] = items) do
    items_html = items
    |> Enum.map(fn {:ul_item, content} -> "<li>#{content}</li>" end)
    |> Enum.join("\n")

    "<ul>\n#{items_html}\n</ul>"
  end

  defp process_chunk([{:code_block_start, lang} | rest]) do
    code_content = rest
    |> Enum.take_while(fn {type, _} -> type != :code_block_end end)
    |> Enum.map(fn {_, content} -> content end)
    |> Enum.join("\n")

    "<pre><code class=\"language-#{lang}\">\n#{escape_html(code_content)}\n</code></pre>"
  end

  defp process_chunk([{type, content}]) do
    case type do
      :h1 -> "<h1>#{content}</h1>"
      :h2 -> "<h2>#{content}</h2>"
      :h3 -> "<h3>#{content}</h3>"
      :h4 -> "<h4>#{content}</h4>"
      :h5 -> "<h5>#{content}</h5>"
      :h6 -> "<h6>#{content}</h6>"
      :p -> "<p>#{content}</p>"
      :blockquote -> "<blockquote>#{content}</blockquote>"
      :hr -> "<hr>"
      :blank -> ""
      _ -> content
    end
  end

  defp process_chunk(elements) do
    Enum.map(elements, fn {type, content} -> process_chunk([{type, content}]) end)
    |> Enum.join("\n")
  end

  @doc """
  Escapes HTML special characters in the given text.
  """
  def escape_html(text) do
    text
    |> String.replace("&", "&amp;")
    |> String.replace("<", "&lt;")
    |> String.replace(">", "&gt;")
    |> String.replace("\"", "&quot;")
  end
end
