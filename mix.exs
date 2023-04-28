defmodule ExPlatform.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_platform,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      dialyzer: [
        plt_add_apps: [:ex_platform],
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ExPlatform.Application, []},
      extra_applications: [:logger, :runtime_tools, :bamboo]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Emails
      {:bamboo, "~> 2.0"},
      {:bamboo_smtp, "~> 4.2.1"},
      {:bamboo_phoenix, "~> 1.0.0"},
      {:premailex, "~> 0.3.0"},

      # User auth
      {:bcrypt_elixir, "~> 3.0"},

      # Phoenix
      {:phoenix, "~> 1.7.0"},
      {:phoenix_live_view, "~> 0.17.5"},
      {:phoenix_html, "~> 3.3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.6.1"},
      {:plug_cowboy, "~> 2.0"},

      # Ecto
      {:phoenix_ecto, "~> 4.1"},
      {:ecto_sql, "~> 3.4"},
      {:postgrex, ">= 0.0.0"},

      # Utils
      {:floki, ">= 0.19.0"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:sentry, "~> 8.0"},

      # I18n
      {:ex_cldr, "~> 2.0"},
      {:ex_money, "~> 5.13.0"},
      {:ex_cldr_dates_times, "~> 2.6"},
      {:ex_cldr_calendars, "~> 1.12"},

      # Tools
      {:credo, "~> 1.7.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},

      # Admin, Kaffy version in hex.pm is very old so we need to pin it
      {:kaffy, github: "aesmail/kaffy", tag: "418893961c67ec77559f9efd90f58c656f051389"},
      {:esbuild, "~> 0.3", runtime: Mix.env() == :dev}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd cd assets && yarn"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      testjs: ["cmd ./node_modules/.bin/jest --colors"],
      "assets.deploy": ["esbuild default --minify", "phx.digest"]
    ]
  end
end
