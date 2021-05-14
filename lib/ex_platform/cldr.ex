defmodule ExPlatform.Cldr do
  use Cldr,
    locales: Gettext.known_locales(ExPlatformWeb.Gettext),
    default_locale: "en",
    otp_app: :ex_platform,
    providers: [Cldr.Number, Money, Cldr.DateTime, Cldr.Calendar]
end
