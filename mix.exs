defmodule MakeupMarkdown.MixProject do
  use Mix.Project

  def project do
    [
      app: :makeup_markdown,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      # Package
      package: package(),
      description: description(),
      docs: [
        main: "readme",
        extras: [
          "README.md"
        ]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:makeup, "~> 1.0"}
    ]
  end

  defp description do
    """
    Markdown lexer for the Makeup syntax highlighter.
    """
  end

  defp package do
    [
      name: :makeup_html,
      licenses: ["MIT"],
      maintainers: ["Fabricio Damazio <fabridamazio@gmail.com>"],
      links: %{"GitHub" => "https://github.com/FabriDamazio/makeup_markdown"}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
