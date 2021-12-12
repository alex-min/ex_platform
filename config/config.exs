# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :esbuild,
  version: "0.13.5",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :ex_platform, ExPlatform.Mailer, adapter: Bamboo.LocalAdapter

config :ex_platform, ExPlatformWeb.Cldr,
  default_locale: "en",
  locales: ["fr", "en"],
  gettext: ExPlatformWeb.Gettext,
  data_dir: "./priv/cldr"

config :ex_platform,
  ecto_repos: [ExPlatform.Repo]

# Configures the endpoint
config :ex_platform, ExPlatformWeb.Endpoint,
  url: [host: "localhost", port: 4000],
  secret_key_base: "5DbQXonRAXilsfYdl5lzyYhGs9L9bw4ynVIbx4JdFXZokjISD/hn949U+4ZAFmzc",
  render_errors: [view: ExPlatformWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ExPlatform.PubSub,
  live_view: [signing_salt: "IXddJjkK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ex_platform, :company_name, "ExPlatform"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
