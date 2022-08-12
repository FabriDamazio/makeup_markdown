defmodule Makeup.Lexers.MarkdownLexer.MarkdownWhitespaces do
  @moduledoc """
    Markdown leaf blocks tokens generator

    Whitespace specification:
    https://spec.commonmark.org/0.30/#characters-and-lines
  """

  import NimbleParsec
  import Makeup.Lexer.Combinators

  def get_whitespaces do
    ascii_string([?\r, ?\s, ?\n, ?\f], min: 1)
  end

  def get_whitespaces_tokens do
    get_whitespaces()
    |> token(:whitespace)
  end

  def get_line_end_tokens do
    choice([string("\r\n"), string("\n")])
    |> optional(get_whitespaces())
    |> token(:whitespace)
  end
end
