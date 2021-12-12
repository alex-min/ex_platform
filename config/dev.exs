import Config

config :ex_platform, ExPlatform.Mailer, adapter: Bamboo.LocalAdapter
config :ex_platform, ExPlatform.Mailer, smtp_email_address: "hello@example.com"

# Configure your database
config :ex_platform, ExPlatform.Repo,
  username: "postgres",
  password: "postgres",
  database: "ex_platform_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it to recompile .js and .css sources.
config :ex_platform, ExPlatformWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    # Start the esbuild watcher by calling Esbuild.install_and_run(:default, args)
    js: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
    node: [
      "node_modules/postcss-cli/index.js",
      "assets/css/app.scss",
      "-o",
      "priv/static/assets/app.css",
      "--watch",
      cd: Path.expand("../", __DIR__)
    ]
  ]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Note that this task requires Erlang/OTP 20 or later.
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :ex_platform, ExPlatformWeb.Endpoint,
  live_reload: [
    iframe_attrs: [style: "display: none"],
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/ex_platform_web/(live|views)/.*(ex)$",
      ~r"lib/ex_platform_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
