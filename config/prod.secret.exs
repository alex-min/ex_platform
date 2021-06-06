# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url = System.get_env("DATABASE_URL") || System.get_env("POSTGRESQL_ADDON_URI")

unless database_url do
  raise """
  environment variable DATABASE_URL or POSTGRESQL_ADDON_URI is missing.
  For example: ecto://USER:PASS@HOST/DATABASE
  """
end

config :ex_platform, ExPlatform.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

smtp_email_address =
  System.get_env("SMTP_EMAIL_ADDRESS") ||
    raise """
      environment variable SMTP_EMAIL_ADDRESS is missing
      For example "hello@example.com"
    """

config :ex_platform, ExPlatform.Mailer, smtp_email_address: smtp_email_address

config :ex_platform, ExPlatform.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: System.get_env("SMTP_HOST") || raise("environment variable SMTP_HOST is missing."),
  port: (System.get_env("SMTP_PORT") || "587") |> String.to_integer(),
  username:
    System.get_env("SMTP_USERNAME") || raise("environment variable SMTP_USERNAME is missing."),
  password:
    System.get_env("SMTP_PASSWORD") || raise("environment variable SMTP_PASSWORD is missing.")

config :ex_platform, ExPlatformWeb.Endpoint,
  http: [
    host:
      System.get_env("HOSTNAME") ||
        raise(
          "environment variable HOSTNAME is missing. (This is the address of your website, like example.org)"
        ),
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# Configuring sentry (optional)
if System.get_env("SENTRY_DSN") do
  config :sentry,
    dsn: System.get_env("SENTRY_DSN"),
    environment_name: :prod,
    enable_source_code_context: true,
    root_source_code_path: File.cwd!(),
    tags: %{
      env: "production"
    },
    included_environments: [:prod]
end
