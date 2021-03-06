defmodule ExPlatformWeb.Hooks.Language do
  @moduledoc """
  Language hook, sets the current global locale
  """
  def on_mount(:set_language, _params, %{"locale" => locale}, socket) do
    ExPlatformWeb.Gettext.set_locale(locale)

    {:cont, socket}
  end

  def on_mount(:set_language, _params, _session, socket) do
    {:cont, socket}
  end
end
