defmodule ExPlatformWeb.UserConfirmationController do
  use ExPlatformWeb, :controller
  import ExPlatformWeb.Gettext

  alias ExPlatform.Accounts

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"email" => email}}) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_confirmation_instructions(
        user,
        &Routes.user_confirmation_url(conn, :confirm, &1)
      )
    end

    # Regardless of the outcome, show an impartial success/error message.
    conn
    |> put_flash(
      :info,
      gettext(
        "If your email is in our system and it has not been confirmed yet, " <>
          "you will receive an email with instructions shortly."
      )
    )
    |> redirect(to: "/")
  end

  @spec confirm_success(Plug.Conn.t()) :: Plug.Conn.t()
  defp confirm_success(conn) do
    if requested_json?(conn) do
      conn |> json(gettext("Account confirmed successfully."))
    else
      conn
      |> put_flash(:info, gettext("Account confirmed successfully."))
      |> redirect(to: "/")
    end
  end

  defp conn_failure(conn) do
    err_text = dgettext("errors", "Account confirmation link is invalid or it has expired.")

    if requested_json?(conn) do
      conn
      |> put_status(400)
      |> json(err_text)
    else
      conn
      |> put_flash(:error, err_text)
      |> redirect(to: "/")
    end
  end

  @spec after_confim(Plug.Conn.t()) :: Plug.Conn.t()
  defp after_confim(conn) do
    if requested_json?(conn) do
      conn |> json(%{status: :ok})
    else
      redirect(conn, to: "/")
    end
  end

  # Do not log in the user after confirmation to avoid a
  # leaked token giving the user access to the account.
  @spec confirm(Plug.Conn.t(), map) :: Plug.Conn.t()
  def confirm(conn, %{"token" => token}) do
    case Accounts.confirm_user(token) do
      {:ok, _} ->
        conn |> confirm_success()

      :error ->
        # If there is a current user and the account was already confirmed,
        # then odds are that the confirmation link was already visited, either
        # by some automation or by the user themselves, so we redirect without
        # a warning message.
        case conn.assigns do
          %{current_user: %{confirmed_at: confirmed_at}} when not is_nil(confirmed_at) ->
            after_confim(conn)

          %{} ->
            conn |> conn_failure()
        end
    end
  end
end
