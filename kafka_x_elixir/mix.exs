defmodule KafkaXElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :kafka_x_elixir,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :kafka_ex],
      mod: {KafkaXElixir.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:broadway, "~> 1.0"},
      {:broadway_kafka, "~> 0.3"},
      {:broadway_dashboard, "~> 0.4.0"},
      {:jason, "~> 1.2"},
      {:kafka_ex, "~> 0.14"},
      {:kayrock, "~> 0.2.0"},
      {:crc32cer, "~> 1.0", override: true},
      {:ecto_sql, "~> 3.5"},
      {:phoenix, "~> 1.7.20"},
      {:phoenix_ecto, "~> 4.5"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_dashboard, "~> 0.8.3"},
      {:postgrex, ">= 0.0.0"}
    ]
  end
end
