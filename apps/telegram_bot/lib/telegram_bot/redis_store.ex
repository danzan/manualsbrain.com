defmodule TelegramBot.RedisStore do
  require Logger

  def set_user_locale(user_id, locale) do
    case Redix.command(:redix, ~w(SET users:#{user_id}:locales #{locale})) do
      {:ok, _} -> nil
      {:error, error} -> log_failure(error)
    end
  end

  def get_user_locale(user_id) do
    case Redix.command(:redix, ~w(GET users:#{user_id}:locales)) do
      {:ok, nil} -> "en"
      {:ok, l} -> l
      {:error, error} -> log_failure(error)
    end
  end

  defp log_failure(%Redix.Error{message: msg}) do
    Logger.log :error, "RedixError. Reason: #{msg}"    
  end

  defp log_failure(%Redix.ConnectionError{reason: reason}) do
    Logger.log :error, "ConnectionError. Reason: #{reason}"
  end
end