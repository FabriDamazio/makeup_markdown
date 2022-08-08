defmodule Makeup.Lexers.MarkdownLexer.MarkdownLine do
  @moduledoc """
    Markdown line token generator

    Lines specification:
    https://spec.commonmark.org/0.30/#characters-and-lines
  """

  import NimbleParsec
  import Makeup.Lexer.Combinators

  def get_text do
    ascii_string([{:not, ?\n}, {:not, ?\r}, {:not, ?#}], min: 1)
  end

  def get_text_token do
    utf8_string([{:not, ?\n}, {:not, ?\r}], min: 1)
    |> token(:text)
  end
end
