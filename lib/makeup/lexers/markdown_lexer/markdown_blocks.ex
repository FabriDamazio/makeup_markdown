defmodule Makeup.Lexers.MarkdownLexer.MarkdownBlocks do
  # Markdown blocks
  # https://spec.commonmark.org/0.30/

  @blocks [
    "***",
    "---",
    "___"
  ]

  def get_blocks(), do: @blocks
end
