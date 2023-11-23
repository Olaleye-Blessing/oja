defmodule Api.MixProject do
  use Mix.Project

  def project do
    [
      app: :api,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Api.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.4"},
      {:postgrex, ">= 0.0.0"},
      {:ecto_sql, "~> 3.11"},
      {:cors_plug, "~> 3.0"},
      {:pbkdf2_elixir, "~> 2.2"},
      {:joken, "~> 2.5"}
    ]
  end
end
