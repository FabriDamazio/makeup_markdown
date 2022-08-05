defmodule Makeup.Lexers.MarkdownLexerTest do
  use ExUnit.Case, async: true

  alias Makeup.Registry
  alias Makeup.Lexers.MarkdownLexer
  alias Makeup.Lexer.Postprocess

  describe "registration" do
    test "fetching the lexer by name" do
      assert {:ok, {MarkdownLexer, []}} == Registry.fetch_lexer_by_name("markdown")
    end

    test "fetching the lexer by extension" do
      assert {:ok, {MarkdownLexer, []}} == Registry.fetch_lexer_by_extension("md")
    end
  end

  describe "lex/1" do
    test "lexing an empty string" do
      assert [] == MarkdownLexer.lex("")
    end
  end
end
