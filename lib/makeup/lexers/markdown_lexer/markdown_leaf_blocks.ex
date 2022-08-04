defmodule Makeup.Lexers.MarkdownLexer.MarkdownLeafBlocks do
  # Markdown blocks
  # https://spec.commonmark.org/0.30/#leaf-blocks

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
end
