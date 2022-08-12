defmodule Makeup.Lexers.LexerTextTest do
  use ExUnit.Case, async: true

  alias Makeup.Lexers.MarkdownLexer

  describe "lex/1" do
    test "lexing a Text" do
      assert [{:text, %{ language: :markdown }, "Text"}] == MarkdownLexer.lex("Text")
    end

    test "lexing a Text with leading space" do
      assert [{:whitespace, %{ language: :markdown }, " "}, {:text, %{ language: :markdown }, "Text"}] == MarkdownLexer.lex(" Text")
    end

    test "lexing a Text with trailing whitespace" do
      assert [{:text, %{ language: :markdown }, "Text "}] == MarkdownLexer.lex("Text ")
    end

    test "lexing a Text with leading and trailing whitespace" do
      assert [{:whitespace, %{ language: :markdown }, " "}, {:text, %{ language: :markdown }, "Text "}] == MarkdownLexer.lex(" Text ")
    end

    test "lexing a Text phrase" do
      assert [{:text, %{ language: :markdown }, "Text Text"}] == MarkdownLexer.lex("Text Text")
    end

    test "lexing a Text phrase with leading whitespace" do
      assert [{:whitespace, %{ language: :markdown }, " "}, {:text, %{ language: :markdown }, "Text Text"}] == MarkdownLexer.lex(" Text Text")
    end
  end
end
