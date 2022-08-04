defmodule Makeup.Lexers.MarkdownLexer.MarkdownWhitespaces do
  @moduledoc """
    Markdown leaf blocks tokens generator

    Leaf blocks specification:
    https://spec.commonmark.org/0.30/#leaf-blocks
  """

  import NimbleParsec
  import Makeup.Lexer.Combinators

  def get_whitspaces, do: ascii_string([?\r, ?\s, ?\n, ?\f], min: 1)

  def get_whitespaces_tokens do
    get_whitspaces()
    |> token(:whitespace)
  end
end
