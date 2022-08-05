defmodule Makeup.Lexers.LexerTextTest do
  use ExUnit.Case, async: true

  alias Makeup.Lexers.MarkdownLexer

  describe "lex/1 lexing text thats look like ATX Heading" do
    test "#1" do
      assert [{:text, %{language: :markdown}, "#1"}] == MarkdownLexer.lex("#1")
    end

    test "1#" do
      assert [{:text, %{language: :markdown}, "1#"}] == MarkdownLexer.lex("1#")
    end

    test "#######" do
      assert [{:text, %{language: :markdown}, "#######"}] == MarkdownLexer.lex("#######")
    end

    test "####### Test" do
      assert [{:text, %{language: :markdown}, "####### Test"}] == MarkdownLexer.lex("####### Test")
    end
  end
end
