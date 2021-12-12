defmodule ExPlatformWeb.Hooks.CurrentUser do
  import Phoenix.LiveView
  alias ExPlatform.Accounts

  def on_mount(:fetch_current_user, _params, %{"user_token" => user_token}, socket) do
    {:cont, assign(socket, :current_user, Accounts.get_user_by_session_token(user_token))}
  end

  def on_mount(:fetch_current_user, _params, _session, socket) do
    {:cont, assign(socket, :current_user, nil)}
  end
end
