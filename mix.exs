defmodule Tortuga.MixProject do
  use Mix.Project

  def project do
    [
      # Basic information
      app: :tortuga,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),

      # Tests
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      elixirc_paths: elixirc_paths(Mix.env()),

      # Docs
      name: "Tortuga",
      source_url: "https://github.com/zvonimirr/tortuga",
      homepage_url: "https://github.com/zvonimirr/tortuga",
      docs: [
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :bunt],
      mod: {Tortuga.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # HTTP
      {:bandit, ">= 0.7.7"},
      # Ecto
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      # Misc.
      {:bunt, "~> 0.2.1"},
      # Tools
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.16.1", only: :test, runtime: false}
    ]
  end

  # Specifies aliases for tasks.
  defp aliases() do
    [
      test: ["ecto.create --quiet", "ecto.migrate", "test"],
      "ecto.setup": ["ecto.create", "ecto.migrate"]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
