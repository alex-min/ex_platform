defmodule ExPlatform.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ExPlatform.Repo,
      # Start the Telemetry supervisor
      ExPlatformWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ExPlatform.PubSub},
      # Start the Endpoint (http/https)
      ExPlatformWeb.Endpoint
      # Start a worker by calling: ExPlatform.Worker.start_link(arg)
      # {ExPlatform.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExPlatform.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ExPlatformWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  @spec company_name :: String.t()
  def company_name do
    Application.get_env(:ex_platform, :company_name)
  end
end
