defmodule Makeup.Lexers.LexerAtxHeadingsTest do
  use ExUnit.Case, async: true
  import Makeup.Lexers.MarkdownLexer, only: [lex: 1]

  import Makeup.Lexers.MarkdownLexer.MarkdownLeafBlocks,
    only: [get_atx_headings: 0]

  ExUnit.Case.register_attribute(__ENV__, :atx_heading)

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

      test "#{atx_heading} with leading whitespace", context do
        x = context.registered.atx_heading
        assert [{:whitespace, %{language: :markdown}, " "}, {:generic_strong, %{language: :markdown}, x}] == lex(" #{x}")
      end
    end

    for atx_heading <- get_atx_headings() do
      @atx_heading atx_heading

      test "#{atx_heading} with trailing whitespace", context do
        x = context.registered.atx_heading
        assert [{:generic_strong, %{language: :markdown}, [x, " "]}] == lex("#{x} ")
      end
    end
  end
end
