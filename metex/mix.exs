# every elixir created project consist on 2 parts :
# Project & application
defmodule Metex.MixProject do
  use Mix.Project

  #setup project dependencies
  def project do
    [
      app: :metex,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # before the application start the logger is started first
      extra_applications: [:logger, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:httpoison, "~> 0.9.0"},
      {:json, "~> 0.3.0"}
    ]
  end
end
