defmodule Routes.Accounts.ApiRoutes do
  @moduledoc """
  User accounts api routes.
  Remove this module from router.ex if you don't need api access.
  """
  defmacro __using__(options \\ []) do
    scoped = Keyword.get(options, :scope, "/api")
    custom_pipes = Keyword.get(options, :pipe_through, [])
    pipes = [] ++ custom_pipes

    quote do
      scope unquote(scoped), ExPlatformWeb, as: :api do
        pipe_through(unquote(pipes))

        post "/users/register", UserRegistrationController, :create
        post "/users/log_in", UserSessionController, :create
        post "/users/reset_password", UserResetPasswordController, :create
        get "/users/confirm/:token", UserConfirmationController, :confirm
      end
    end
  end
end
