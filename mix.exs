defmodule Md2html.MixProject do
  use Mix.Project

  def project do
    [
      app: :md2html,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: Md2html.CLI],
      name: "Markdown to HTML Converter",
      source_url: "https://github.com/sijanthapa171/md-html"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end
end
