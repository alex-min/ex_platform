defmodule ExPlatformWeb.UserRegistrationController do
  use ExPlatformWeb, :controller

  alias ExPlatform.Accounts
  alias ExPlatform.Accounts.User
  alias ExPlatformWeb.UserAuth

  import ExPlatformWeb.Gettext

  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :confirm, &1)
          )

        conn
        |> put_flash(:info, gettext("User created successfully."))
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(400)
        |> render(:new, changeset: changeset)
    end
  end
end
