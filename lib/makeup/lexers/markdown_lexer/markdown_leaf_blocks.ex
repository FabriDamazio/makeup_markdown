defmodule Makeup.Lexers.MarkdownLexer.MarkdownLeafBlocks do
  @moduledoc """
    Markdown leaf blocks tokens generator

    Leaf blocks specification:
    https://spec.commonmark.org/0.30/#leaf-blocks
  """

  import NimbleParsec
  import Makeup.Lexer.Combinators
  alias Makeup.Lexers.MarkdownLexer.MarkdownWhitespaces

  # https://spec.commonmark.org/0.30/#atx-headings
  @atx_headings [
    "#",
    "##",
    "###",
    "####",
    "#####",
    "######"
  ]

  def get_atx_headings(), do: @atx_headings

  def get_atx_headings_tokens() do
    atx =
      @atx_headings
      |> Enum.map(fn x ->
        x
        |> string()
        |> optional(MarkdownWhitespaces.get_whitespaces())
        |> eos()
        |> token(:generic_strong)
      end)

    atx
  end
end
