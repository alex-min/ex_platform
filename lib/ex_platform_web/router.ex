defmodule ExPlatformWeb.Router do
  use ExPlatformWeb, :router

  import ExPlatformWeb.UserAuth

  use Kaffy.Routes, scope: "/admin", pipe_through: [:browser, :require_admin_user]

  use Routes.Accounts.Logged, pipe_through: [:browser, :require_authenticated_user]
  use Routes.Accounts.AuthRoutes, pipe_through: [:browser, :redirect_if_user_is_authenticated]
  use Routes.Accounts.ApiRoutes, scope: "/api", pipe_through: [:api]
  use Routes.Accounts.UnloggedActions, pipe_through: [:browser]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ExPlatformWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug Cldr.Plug.AcceptLanguage, cldr_backend: ExPlatform.Cldr
    plug ExPlatformWeb.Plugs.I18n
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_current_user
    plug ExPlatformWeb.Plugs.I18n
    plug ExPlatformWeb.Plugs.NoFlash

    plug Plug.Parsers,
      parsers: [:json],
      json_decoder: {Jason, :decode!, []},
      keys: :atoms
  end

  scope "/", ExPlatformWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    forward "/sent_emails", Bamboo.SentEmailViewerPlug

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ExPlatformWeb.Telemetry
    end
  end
end
