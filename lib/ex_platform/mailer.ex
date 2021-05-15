defmodule ExPlatform.Mailer do
  @moduledoc """
    Sends emails
  """
  use Bamboo.Mailer, otp_app: :ex_platform
  import Bamboo.Email

  @spec inline_css(Bamboo.Email.t()) :: Bamboo.Email.t()
  def inline_css(email) do
    html = Premailex.to_inline_css(email.html_body)
    text = Premailex.to_text(email.html_body)

    email
    |> html_body(html)
    |> text_body(text)
  end

  @spec smtp_email_address :: String.t()
  def smtp_email_address do
    Application.get_env(:ex_platform, ExPlatform.Mailer)[:smtp_email_address]
  end
end
