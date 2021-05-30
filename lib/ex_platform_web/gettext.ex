defmodule ExPlatformWeb.Gettext do
  @moduledoc """
  A module providing Internationalization with a gettext-based API.

  By using [Gettext](https://hexdocs.pm/gettext),
  your module gains a set of macros for translations, for example:

      import ExPlatformWeb.Gettext

      # Simple translation
      dgettext("auth", "Here is the string to translate")

      # Plural translation
      ngettext("Here is the string to translate",
               "Here are the strings to translate",
               3)

      # Domain-based translation
      dgettext("errors", "Here is the error message to translate")

  See the [Gettext Docs](https://hexdocs.pm/gettext) for detailed usage.
  """
  use Gettext, otp_app: :ex_platform

  @spec set_locale(Gettext.locale()) :: nil
  def set_locale(locale) do
    Gettext.put_locale(ExPlatformWeb.Gettext, locale)
  end
end
