defmodule Routes.Accounts.AuthRoutes do
  @moduledoc """
    Actions to auth & register users.
    These routes should be public but not available to authenticated users.
  """
  defmacro __using__(options \\ []) do
    scoped = Keyword.get(options, :scope, "/")
    custom_pipes = Keyword.get(options, :pipe_through, [])
    pipes = [] ++ custom_pipes

    quote do
      scope unquote(scoped), ExPlatformWeb do
        pipe_through(unquote(pipes))

        get "/users/register", UserRegistrationController, :new
        post "/users/register", UserRegistrationController, :create
        live "/users/log_in", UserSessionLive, :new
        post "/users/log_in", UserSessionController, :create
      end
    end
  end
end
