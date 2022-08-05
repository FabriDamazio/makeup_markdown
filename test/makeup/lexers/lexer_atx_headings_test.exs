defmodule Makeup.Lexers.LexerAtxHeadingsTest do
  use ExUnit.Case, async: true

  alias Makeup.Lexers.MarkdownLexer

  describe "lex/1 lexing ATX Heading" do
    test "#" do
      assert [{:generic_strong, %{language: :markdown}, "#"}] == MarkdownLexer.lex("#")
    end

    test "##" do
      assert [{:generic_strong, %{language: :markdown}, "##"}] == MarkdownLexer.lex("##")
    end

    test "###" do
      assert [{:generic_strong, %{language: :markdown}, "###"}] == MarkdownLexer.lex("###")
    end

    test "####" do
      assert [{:generic_strong, %{language: :markdown}, "####"}] == MarkdownLexer.lex("####")
    end

    test "#####" do
      assert [{:generic_strong, %{language: :markdown}, "#####"}] == MarkdownLexer.lex("#####")
    end

    test "######" do
      assert [{:generic_strong, %{language: :markdown}, "######"}] == MarkdownLexer.lex("######")
    end

    test "# with trailing space" do
      assert [{:generic_strong, %{language: :markdown}, ["#", " "]}] == MarkdownLexer.lex("# ")
    end

    test "## with trailing space" do
      assert [{:generic_strong, %{language: :markdown}, ["##", " "]}] == MarkdownLexer.lex("## ")
    end

    test "### with trailing space" do
      assert [{:generic_strong, %{language: :markdown}, ["###", " "]}] == MarkdownLexer.lex("### ")
    end

    test "#### with trailing space" do
      assert [{:generic_strong, %{language: :markdown}, ["####", " "]}] == MarkdownLexer.lex("#### ")
    end

    test "##### with trailing space" do
      assert [{:generic_strong, %{language: :markdown}, ["#####", " "]}] == MarkdownLexer.lex("##### ")
    end

    test "###### with trailing space" do
      assert [{:generic_strong, %{language: :markdown}, ["######", " "]}] == MarkdownLexer.lex("###### ")
    end

    test "# with Text" do
      assert [{:generic_strong, %{language: :markdown}, ["#", " ", "Test"]}] == MarkdownLexer.lex("# Test")
    end

    test "## with Text" do
      assert [{:generic_strong, %{language: :markdown}, ["##", " ", "Test"]}] == MarkdownLexer.lex("## Test")
    end

    test "### with Text" do
      assert [{:generic_strong, %{language: :markdown}, ["###", " ", "Test"]}] == MarkdownLexer.lex("### Test")
    end

    test "#### with Text" do
      assert [{:generic_strong, %{language: :markdown}, ["####", " ", "Test"]}] == MarkdownLexer.lex("#### Test")
    end

    test "##### with Text" do
      assert [{:generic_strong, %{language: :markdown}, ["#####", " ", "Test"]}] == MarkdownLexer.lex("##### Test")
    end

    test "###### with Text" do
      assert [{:generic_strong, %{language: :markdown}, ["######", " ", "Test"]}] == MarkdownLexer.lex("###### Test")
    end
  end
end
