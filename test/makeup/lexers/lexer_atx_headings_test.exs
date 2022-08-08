defmodule Makeup.Lexers.LexerAtxHeadingsTest do
  use ExUnit.Case, async: true
  import Makeup.Lexers.MarkdownLexer, only: [lex: 1]

  import Makeup.Lexers.MarkdownLexer.MarkdownLeafBlocks,
    only: [get_atx_headings: 0, get_set_text_headings: 0]

  ExUnit.Case.register_attribute(__ENV__, :atx_heading)
  ExUnit.Case.register_attribute(__ENV__, :set_text_heading)

  describe "lex/1 lexing ATX Heading" do
    for atx_heading <- get_atx_headings() do
      @atx_heading atx_heading

      test "#{atx_heading}", context do
        x = context.registered.atx_heading
        assert [{:generic_strong, %{language: :markdown}, x}] == lex(x)
      end
    end

    for atx_heading <- get_atx_headings() do
      @atx_heading atx_heading

      test "#{atx_heading} with trailing space", context do
        x = context.registered.atx_heading

        assert [{:generic_strong, %{language: :markdown}, [x, " "]}] ==
                 lex(x <> " ")
      end
    end

    for atx_heading <- get_atx_headings() do
      @atx_heading atx_heading

      test "#{atx_heading} with trailing Text", context do
        x = context.registered.atx_heading

        assert [
                 {:generic_strong, %{language: :markdown}, [x, " "]},
                 {:generic_heading, %{language: :markdown}, "Test"}
               ] ==
                 lex(x <> " Test")
      end
    end

    for atx_heading <- get_atx_headings() do
      @atx_heading atx_heading

      test "#{atx_heading} with Text and trailing ATX Heading", context do
        x = context.registered.atx_heading

        assert [
                 {:generic_strong, %{language: :markdown}, [x, " "]},
                 {:generic_heading, %{language: :markdown}, "Test "},
                 {:generic_strong, %{language: :markdown}, x}
               ] ==
                 lex(x <> " Test " <> x)
      end
    end
  end

  describe "lex/1 lexing Set Text Heading" do
    for set_text_heading <- get_set_text_headings() do
      @set_text_heading set_text_heading

      test "#{set_text_heading}", context do
        x = context.registered.set_text_heading

        assert [{:generic_heading, %{language: :markdown}, ["Title", "\n", x]}, {:whitespace, %{language: :markdown}, "\n"}] ==
                 lex("""
                 Title
                 #{x}
                 """)
      end
    end

    for set_text_heading <- get_set_text_headings() do
      @set_text_heading set_text_heading

      test "#{set_text_heading}#{set_text_heading}", context do
        x = context.registered.set_text_heading
        assert [{:generic_heading, %{language: :markdown}, ["Title", "\n", x, x]}, {:whitespace, %{language: :markdown}, "\n"}] ==
          lex("""
          Title
          #{x}#{x}
          """)
      end
    end
  end
end
