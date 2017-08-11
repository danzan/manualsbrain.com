defmodule TelegramBot.Gettext do
  use Gettext, otp_app: :telegram_bot

  def available_locales do
    ["en", "de", "es", "fr", "it", "pt", "ru", "ko", "ja", "zh"]
  end
end