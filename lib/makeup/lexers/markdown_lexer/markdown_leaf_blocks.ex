defmodule Makeup.Lexers.MarkdownLexer.MarkdownLeafBlocks do
  @moduledoc """
    Markdown leaf blocks tokens generator

    Leaf blocks specification:
    https://spec.commonmark.org/0.30/#leaf-blocks
  """

  import NimbleParsec
  import Makeup.Lexer.Combinators
  alias Makeup.Lexers.MarkdownLexer.MarkdownWhitespaces
  alias Makeup.Lexers.MarkdownLexer.MarkdownLine

  # https://spec.commonmark.org/0.30/#atx-headings
  @atx_headings [
    "#",
    "##",
    "###",
    "####",
    "#####",
    "######"
  ]

  # https://spec.commonmark.org/0.30/#setext-heading
  @set_text_headings [
    "-",
    "="
  ]

  def get_atx_headings(), do: @atx_headings

  def get_atx_headings_tokens() do
    atx =
      @atx_headings
      |> Enum.map(fn x ->
        x
        |> string()
        |> eos()
        |> token(:generic_strong)
      end)

    atx_with_text =
      @atx_headings
      |> Enum.map(fn x ->
        x
        |> string()
        |> concat(MarkdownWhitespaces.get_whitespaces())
        |> token(:generic_strong)
        |> optional(MarkdownLine.get_text() |> token(:generic_heading))
      end)

    atx_with_trailing_space =
      @atx_headings
      |> Enum.map(fn x ->
        x
        |> string()
        |> concat(MarkdownWhitespaces.get_line_end())
        |> token(:generic_strong)
      end)

    atx ++ atx_with_text ++ atx_with_trailing_space
  end

  def get_set_text_headings(), do: @set_text_headings

  def get_set_text_headings_tokens() do
    MarkdownLine.get_text()
    |> concat(MarkdownWhitespaces.get_line_end())
    |> concat(
      choice(
        get_set_text_headings()
        |> Enum.map(&string/1)
      )
      |> times(min: 1)
    )
    |> lookahead_not(MarkdownLine.get_text())
    |> token(:generic_heading)
  end
end
