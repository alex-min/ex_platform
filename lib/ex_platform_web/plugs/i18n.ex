# adapted from https://phrase.com/blog/posts/set-and-manage-locale-data-in-your-phoenix-l10n-project/
defmodule ExPlatformWeb.Plugs.I18n do
  import Plug.Conn

  alias ExPlatform.Cldr

  @locales Gettext.known_locales(ExPlatformWeb.Gettext)

  def init(default_locale), do: default_locale

  defp locale_from_header(conn) do
    conn
    |> extract_accept_language
    |> Enum.find(nil, fn accepted_locale -> Enum.member?(@locales, accepted_locale) end)
  end

  def extract_accept_language(conn) do
    case Plug.Conn.get_req_header(conn, "accept-language") do
      [value | _] ->
        value
        |> String.split(",")
        |> Enum.map(&parse_language_option/1)
        |> Enum.sort(&(&1.quality > &2.quality))
        |> Enum.map(& &1.tag)
        |> Enum.reject(&is_nil/1)
        |> ensure_language_fallbacks()

      _ ->
        []
    end
  end

  defp persist_locale(conn, new_locale) do
    conn |> put_session(:locale, new_locale)
  end

  defp locale_from_cookies(conn) do
    conn |> get_session(:locale)
  end

  defp parse_language_option(string) do
    captures = Regex.named_captures(~r/^\s?(?<tag>[\w\-]+)(?:;q=(?<quality>[\d\.]+))?$/i, string)

    quality =
      case Float.parse(captures["quality"] || "1.0") do
        {val, _} -> val
        _ -> 1.0
      end

    %{tag: captures["tag"], quality: quality}
  end

  defp ensure_language_fallbacks(tags) do
    Enum.flat_map(tags, fn tag ->
      [language | _] = String.split(tag, "-")
      if Enum.member?(tags, language), do: [tag], else: [tag, language]
    end)
  end

  def call(%Plug.Conn{params: %{"locale" => locale}} = conn, _opts) do
    Gettext.put_locale(locale)
    Cldr.put_locale(locale)
    conn
  end

  def call(conn, _opts) do
    case locale_from_header(conn) || locale_from_cookies(conn) do
      nil ->
        conn

      locale ->
        Gettext.put_locale(locale)
        Cldr.put_locale(locale)

        conn = conn |> persist_locale(locale)
        conn
    end
  end
end
