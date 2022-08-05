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

  def get_atx_headings_tokens() do
    atx = @atx_headings
    |> Enum.map(fn x ->
      x
      |> string()
      |> eos()
      |> token(:generic_strong)
    end)

    atx_with_trailing_space = @atx_headings
    |> Enum.map(fn x ->
      x
      |> string()
      |> concat(MarkdownWhitespaces.get_whitspaces())
      |> optional(MarkdownLine.get_text())
      |> token(:generic_strong)
    end)

    atx ++ atx_with_trailing_space
  end
end
