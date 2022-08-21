defmodule Makeup.Lexers.LexerAtxHeadingsTest do
  use ExUnit.Case, async: true

  import Makeup.Lexers.MarkdownLexer, only: [lex: 1]

  import Makeup.Lexers.MarkdownLexer.MarkdownLeafBlocks,
    only: [get_atx_headings: 0]

  ExUnit.Case.register_attribute(__ENV__, :atx_heading)

  describe "lex/1 lexing ATX Heading - " do
    for atx_heading <- get_atx_headings() do
      @atx_heading atx_heading

      test "#{atx_heading}", context do
        heading = context.registered.atx_heading

        heading_to_assert =
          case String.graphemes(heading) do
            [x] -> x
            x -> x
          end

        assert [{:generic_strong, %{language: :markdown}, heading_to_assert}] == lex(heading)
      end
    end
  end

  describe "lex/1 lexing ATX Heading with one leading space - " do
    for atx_heading <- get_atx_headings() do
      @atx_heading atx_heading

      test "#{atx_heading}", context do
        x = context.registered.atx_heading

        assert [{:generic_strong, %{language: :markdown}, [" "] ++ String.graphemes(x)}] ==
                 lex(" #{x}")
      end
    end
  end

  describe "lex/1 lexing ATX Heading with two leading space - " do
    for atx_heading <- get_atx_headings() do
      @atx_heading atx_heading

      test "#{atx_heading}", context do
        x = context.registered.atx_heading

        assert [{:generic_strong, %{language: :markdown}, [" ", " "] ++ String.graphemes(x)}] ==
                 lex("  #{x}")
      end
    end
  end

  describe "lex/1 lexing ATX Heading with three leading space - " do
    for atx_heading <- get_atx_headings() do
      @atx_heading atx_heading

      test "#{atx_heading}", context do
        x = context.registered.atx_heading

        assert [{:generic_strong, %{language: :markdown}, [" ", " ", " "] ++ String.graphemes(x)}] ==
                 lex("   #{x}")
      end
    end
  end

  describe "lex/1 lexing ATX Heading with one trailing space - " do
    for atx_heading <- get_atx_headings() do
      @atx_heading atx_heading

      test "#{atx_heading}", context do
        x = context.registered.atx_heading

        assert [{:generic_strong, %{language: :markdown}, String.graphemes(x) ++ [" "]}] ==
                 lex("#{x} ")
      end
    end
  end

  describe "lex/1 lexing ATX Heading with two trailing space - " do
    for atx_heading <- get_atx_headings() do
      @atx_heading atx_heading

      test "#{atx_heading}", context do
        x = context.registered.atx_heading

        assert [{:generic_strong, %{language: :markdown}, String.graphemes(x) ++ ["  "]}] ==
                 lex("#{x}  ")
      end
    end
  end

  describe "lex/1 lexing ATX Heading with more than three leading space - " do
    for atx_heading <- get_atx_headings() do
      @atx_heading atx_heading

      test "#{atx_heading}", context do
        x = context.registered.atx_heading

        assert [
                 {:text, %{language: :markdown}, "    #{x}"}
               ] ==
                 lex("    #{x}")
      end
    end
  end

  describe "lex/1 - its not an ATX Heading - " do
    test "More than six # - #######" do
      assert [{:text, %{language: :markdown}, "#######"}] == lex("#######")
    end

    test "Atx with text without space - #Test" do
      assert [{:text, %{language: :markdown}, "#Test"}] == lex("#Test")
    end

    test "Atx with text with more than six # - ####### Test" do
      assert [{:text, %{language: :markdown}, "####### Test"}] == lex("####### Test")
    end
  end

  describe "lex/1 lexing multiline ATX headings" do
    test "without heading text" do
      assert [
               {:generic_strong, %{language: :markdown}, ["#", "\n"]},
               {:generic_strong, %{language: :markdown}, ["#", "#", "\n"]}
             ] ==
               lex("""
               #
               ##
               """)
    end

    test "with heading text" do
      assert [
               {:generic_strong, %{language: :markdown}, ["#", " "]},
               {:text, %{language: :markdown}, "Test"},
               {:whitespace, %{language: :markdown}, "\n"},
               {:generic_strong, %{language: :markdown}, ["#", "#", " "]},
               {:text, %{language: :markdown}, "test"},
               {:whitespace, %{language: :markdown}, "\n"}
             ] ==
               lex("""
               # Test
               ## test
               """)
    end
  end
end
