defmodule Makeup.Lexers.MarkdownLexer do
  @moduledoc """
    Lexer for the Markdown language to be used
    with the Makeup package.
  """

  @behaviour Makeup.Lexer

  import NimbleParsec
  import Makeup.Lexer.Combinators
  alias Makeup.Lexers.MarkdownLexer.MarkdownLeafBlocks

  whitespace = ascii_string([?\r, ?\s, ?\n, ?\f], min: 1)

  line = utf8_string([{:not, ?\n}, {:not, ?\r}], min: 1)

  atx_headings =
    MarkdownLeafBlocks.get_atx_headings()
    |> Enum.map(fn x ->
      x
      |> string()
      |> concat(whitespace)
      |> token(:generic_strong)
    end)

  text = token(line, :text)

  root_element_combinator = choice(atx_headings ++ [text])

  @doc false
  def __as_markdown_language__({type, meta, value}) do
    {type, Map.put(meta, :language, :markdown), value}
  end

  @impl Makeup.Lexer
  defparsec(
    :root_element,
    root_element_combinator |> map({__MODULE__, :__as_markdown_language__, []})
  )

  @impl Makeup.Lexer
  defparsec(:root, repeat(parsec(:root_element)))

  @impl Makeup.Lexer
  def postprocess(tokens, _opts \\ []), do: tokens

  @impl Makeup.Lexer
  def match_groups(tokens, _opts \\ []), do: tokens

  @impl Makeup.Lexer
  def lex(text, _opts \\ []) do
    {:ok, tokens, "", _, _, _} = root(text)

    tokens
    |> postprocess()
    |> match_groups()
  end
end
