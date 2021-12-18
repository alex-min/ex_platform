defmodule Routes.Accounts.UnloggedActions do
  defmacro __using__(options \\ []) do
    scoped = Keyword.get(options, :scope, "/")
    custom_pipes = Keyword.get(options, :pipe_through, [])
    pipes = [] ++ custom_pipes

    quote do
      scope unquote(scoped), ExPlatformWeb do
        pipe_through(unquote(pipes))

        get "/users/reset_password", UserResetPasswordController, :new
        post "/users/reset_password", UserResetPasswordController, :create
        get "/users/reset_password/:token", UserResetPasswordController, :edit
        put "/users/reset_password/:token", UserResetPasswordController, :update

        delete "/users/log_out", UserSessionController, :delete
        get "/users/confirm", UserConfirmationController, :new
        post "/users/confirm", UserConfirmationController, :create
        get "/users/confirm/:token", UserConfirmationController, :confirm
      end
    end
  end
end
