defmodule Makeup.Lexers.MarkdownLexer do
  @moduledoc """
    Lexer for the Markdown language to be used
    with the Makeup package.
  """

  @behaviour Makeup.Lexer

  import NimbleParsec
  alias Makeup.Lexers.MarkdownLexer.MarkdownLeafBlocks
  alias Makeup.Lexers.MarkdownLexer.MarkdownWhitespaces
  alias Makeup.Lexers.MarkdownLexer.MarkdownText

  root_element_combinator =
    choice(
      MarkdownLeafBlocks.get_atx_headings_tokens() ++
        [
          MarkdownWhitespaces.get_whitespaces_tokens(),
          MarkdownWhitespaces.get_line_end_tokens(),
          MarkdownText.get_text_token()
        ]
    )

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
