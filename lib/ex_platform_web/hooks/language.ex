defmodule ExPlatformWeb.Hooks.Language do
  def on_mount(:set_language, _params, %{"locale" => locale}, socket) do
    Gettext.put_locale(ExPlatformWeb.Gettext, locale)

    {:cont, socket}
  end

  def on_mount(:set_language, _params, _session, socket) do
    {:cont, socket}
  end
end
