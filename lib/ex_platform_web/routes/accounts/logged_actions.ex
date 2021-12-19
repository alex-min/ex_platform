defmodule Routes.Accounts.LoggedActions do
  @moduledoc """
    Logged actions from accounts.
    These routes needs to be behind authentication.
  """
  defmacro __using__(options \\ []) do
    scoped = Keyword.get(options, :scope, "/")
    custom_pipes = Keyword.get(options, :pipe_through, [])
    pipes = [] ++ custom_pipes

    quote do
      scope unquote(scoped), ExPlatformWeb do
        pipe_through(unquote(pipes))

        get "/users/settings", UserSettingsController, :edit
        put "/users/settings", UserSettingsController, :update
        get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
      end
    end
  end
end
