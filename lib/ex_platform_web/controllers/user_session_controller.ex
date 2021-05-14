defmodule ExPlatformWeb.UserSessionController do
  use ExPlatformWeb, :controller

  alias ExPlatform.Accounts
  alias ExPlatformWeb.UserAuth

  import ExPlatformWeb.Gettext

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    render(conn, :new, error_message: nil)
  end

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      UserAuth.log_in_user(conn, user, user_params)
    else
      conn
      |> put_status(400)
      |> render(:new, error_message: dgettext("errors", "Invalid email or password"))
    end
  end

  @spec delete(Plug.Conn.t(), any) :: Plug.Conn.t()
  def delete(conn, _params) do
    conn
    |> put_flash(:info, gettext("Logged out successfully."))
    |> UserAuth.log_out_user()
  end
end
