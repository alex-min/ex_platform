defmodule ExPlatform.Accounts.UserNotifier do
  @moduledoc """
    Delivers registration emails
  """
  import Bamboo.Email
  use Bamboo.Phoenix, view: ExPlatformWeb.LayoutView
  alias ExPlatform.ActionEmail
  import ExPlatformWeb.Gettext

  alias ExPlatform.Mailer
  # For simplicity, this module simply logs messages to the terminal.
  # You should replace it by a proper email or notification tool, such as:
  #
  #   * Swoosh - https://hexdocs.pm/swoosh
  #   * Bamboo - https://hexdocs.pm/bamboo
  #
  @spec deliver(ActionEmail.t()) :: {:ok, Bamboo.Email.t()}
  defp deliver(email) do
    new_email(
      to: email.to,
      from: Mailer.smtp_email_address(),
      subject: email.title
    )
    |> put_layout({ExPlatformWeb.LayoutView, :email_action})
    |> assign(:email, email)
    |> render(:email_action)
    |> Mailer.inline_css()
    |> Mailer.deliver_now()
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    deliver(%ActionEmail{
      to: user.email,
      title: dgettext("auth", "Confirm your account"),
      top_text:
        dgettext(
          "auth",
          """
          Hi %{email},

          You can confirm your account by clicking below:
          """,
          email: user.email
        ),
      link_to: url,
      link_text: dgettext("auth", "Confirm my account"),
      bottom_text:
        dgettext("auth", "If you didn't create an account with us, please ignore this.")
    })
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    deliver(%ActionEmail{
      to: user.email,
      title: dgettext("auth", "Reset your password"),
      top_text:
        dgettext(
          "auth",
          """
          Hi %{email},

          You can reset your password by clicking below:
          """,
          email: user.email
        ),
      link_to: url,
      link_text: dgettext("auth", "Reset my password"),
      bottom_text: dgettext("auth", "If you didn't request this change, please ignore this.")
    })
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    deliver(%ActionEmail{
      to: user.email,
      title: dgettext("auth", "Change your email"),
      top_text:
        dgettext(
          "auth",
          """
          Hi %{email},

          You can change your email by clicking below:
          """,
          email: user.email
        ),
      link_to: url,
      link_text: dgettext("auth", "Change my email"),
      bottom_text: dgettext("auth", "If you didn't request this change, please ignore this.")
    })
  end
end
