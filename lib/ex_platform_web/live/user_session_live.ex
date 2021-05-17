defmodule ExPlatformWeb.UserSessionLive do
  @moduledoc """
   homepage
  """
  use ExPlatformWeb, :live_view

  alias ExPlatform.Accounts.User

  def mount(_params, %{"locale" => locale}, socket) do
    Gettext.put_locale(ExPlatformWeb.Gettext, locale)

    {:ok,
     assign(socket,
       changeset: User.registration_changeset(%User{}, %{}),
       error_message: nil
     )}
  end

  def mount(_params, _, socket) do
    {:ok,
     assign(socket,
       changeset: User.registration_changeset(%User{}, %{}),
       error_message: nil
     )}
  end

  def handle_params(%{}, _url, socket) do
    {:noreply, socket}
  end
end
