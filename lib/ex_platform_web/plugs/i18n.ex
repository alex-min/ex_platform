defmodule ExPlatformWeb.Plugs.I18n do
  @moduledoc """
    I18n plug to set the language on an HTTP request.
  """
  import Plug.Conn

  def init(param), do: param

  def call(%Plug.Conn{private: %{cldr_locale: %Cldr.LanguageTag{language: locale}}} = conn, _opts) do
    Gettext.put_locale(locale)
    ExPlatform.Cldr.put_locale(locale)
    conn |> put_session(:locale, locale)
  end

  def call(conn, _opts), do: conn |> put_session(:locale, "en")
end
