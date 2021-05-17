defmodule ExPlatformWeb.Router do
  use ExPlatformWeb, :router

  import ExPlatformWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ExPlatformWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug ExPlatformWeb.Plugs.I18n, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_current_user
    plug ExPlatformWeb.Plugs.I18n, "en"
    plug ExPlatformWeb.Plugs.NoFlash

    plug Plug.Parsers,
      parsers: [:json],
      json_decoder: {Jason, :decode!, []},
      keys: :atoms
  end

  scope "/", ExPlatformWeb do
    pipe_through :browser

    live "/", PageLive, :index

    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
  end

  scope "/api", ExPlatformWeb, as: :api do
    pipe_through [:api]

    post "/users/register", UserRegistrationController, :create
    post "/users/log_in", UserSessionController, :create
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
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

  ## Authentication routes

  scope "/", ExPlatformWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    live "/users/log_in", UserSessionLive, :new
    post "/users/log_in", UserSessionController, :create
  end

  scope "/", ExPlatformWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end
end
