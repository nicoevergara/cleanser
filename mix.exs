defmodule Cleanser.MixProject do
  use Mix.Project

  @repo "https://github.com/nicoevergara/cleanser"

  def project do
    [
      app: :cleanser,
      version: "0.2.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),

      # Docs
      name: "Cleanser",
      source_url: @repo,
      homepage_url: "http://hex.pm/cleanser",
      docs: [main: "Cleanser",
              markdown_processor: ExDoc.Markdown.Cmark,
              extras: ["README.md"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
  [
    {:ex_doc, "~> 0.16", only: :dev, runtime: false},
    {:cmark, "~> 0.7", only: :dev}
  ]
  end


  defp description() do
    "An email validation library (with more to come) written entirely in Elixir!"
  end

  defp package do
    [ maintainers: ["Nico Vergara"],
      licenses: ["MIT"],
      links: %{"GitHub" => @repo}]
  end
end
