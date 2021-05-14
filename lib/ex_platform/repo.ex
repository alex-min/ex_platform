defmodule ExPlatform.Repo do
  use Ecto.Repo,
    otp_app: :ex_platform,
    adapter: Ecto.Adapters.Postgres
end
