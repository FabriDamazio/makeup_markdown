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

  @doc false
  def get_atx_headings(), do: @atx_headings

  def get_atx_headings_tokens() do
    times(string(" "), max: 3)
    |> concat(
      string("#")
      |> times(min: 1, max: 6)
    )
    |> optional(MarkdownWhitespaces.get_whitespaces())
    |> token(:generic_strong)
  end
end
