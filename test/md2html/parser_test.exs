defmodule Md2html.ParserTest do
  use ExUnit.Case
  alias Md2html.Parser

  describe "parse/1" do
    test "parses headers" do
      assert Parser.parse("# Header 1") == [{:h1, "Header 1"}]
      assert Parser.parse("## Header 2") == [{:h2, "Header 2"}]
      assert Parser.parse("### Header 3") == [{:h3, "Header 3"}]
    end

    test "parses paragraphs" do
      assert Parser.parse("Normal text") == [{:p, "Normal text"}]
      assert Parser.parse("Line 1\nLine 2") == [{:p, "Line 1"}, {:p, "Line 2"}]
    end

    test "parses lists" do
      assert Parser.parse("- Item 1\n- Item 2") == [
        {:ul_item, "Item 1"},
        {:ul_item, "Item 2"}
      ]
    end

    test "parses code blocks" do
      markdown = """
      ```elixir
      def hello do
        IO.puts "Hello"
      end
      ```
      """
      assert Parser.parse(markdown) == [
        {:code_block_start, "elixir"},
        {:p, "def hello do"},
        {:p, "  IO.puts \"Hello\""},
        {:p, "end"},
        {:code_block_end, ""}
      ]
    end
  end

  describe "apply_inline/1" do
    test "processes bold text" do
      assert Parser.apply_inline("This is **bold** text") ==
        "This is <strong>bold</strong> text"
    end

    test "processes italic text" do
      assert Parser.apply_inline("This is *italic* text") ==
        "This is <em>italic</em> text"
    end

    test "processes inline code" do
      assert Parser.apply_inline("This is `code` text") ==
        "This is <code>code</code> text"
    end

    test "processes links" do
      assert Parser.apply_inline("This is a [link](https://example.com)") ==
        "This is a <a href=\"https://example.com\">link</a>"
    end

    test "processes multiple inline elements" do
      assert Parser.apply_inline("**Bold** and *italic* and `code`") ==
        "<strong>Bold</strong> and <em>italic</em> and <code>code</code>"
    end
  end
end
