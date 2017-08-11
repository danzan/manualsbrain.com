defmodule TelegramBot.Commander do
  # Code injectors

  defmacro __using__(_opts) do
    quote do
      require Logger
      import TelegramBot.Commander
      alias Nadia.Model
      alias Nadia.Model.InlineQueryResult
    end
  end

  # Sender Macros

  defmacro answer_callback_query(options \\ []) do
    quote bind_quoted: [options: options] do
      Nadia.answer_callback_query var!(update).callback_query.id, options
    end
  end

  defmacro answer_inline_query(results, options \\ []) do
    quote bind_quoted: [results: results, options: options] do
      Nadia.answer_inline_query var!(update).inline_query.id, results, options
    end
  end

  defmacro send_message(text, options \\ []) do
    quote bind_quoted: [text: text, options: options] do
      Nadia.send_message get_chat_id(), text, options
    end
  end

  # Helpers

  defmacro get_chat_id do
    quote do
      case var!(update) do
        %{inline_query: inline_query} when not is_nil(inline_query) ->
          inline_query.from.id
        %{callback_query: callback_query} when not is_nil(callback_query) ->
          callback_query.message.chat.id
        update ->
          update.message.chat.id
      end
    end
  end
end
