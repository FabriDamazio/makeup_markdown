defmodule Makeup.Lexers.LexerWhitespaceTest do
  use ExUnit.Case, async: true

  alias Makeup.Lexers.MarkdownLexer

  describe "lex/1" do
    test "lexing an empty string" do
      assert [] == MarkdownLexer.lex("")
    end

    test "lexing a whitespace" do
      assert [{:text, %{language: :markdown}, " "}] == MarkdownLexer.lex(" ")
    end

    test "lexing \n" do
      assert [{:whitespace, %{language: :markdown}, "\n"}] == MarkdownLexer.lex("\n")
    end

    test "lexing \n\f" do
      assert [{:whitespace, %{language: :markdown}, ["\n", "\f"]}] == MarkdownLexer.lex("\n\f")
    end
  end
end
