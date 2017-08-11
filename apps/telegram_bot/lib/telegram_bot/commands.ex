defmodule TelegramBot.Commands do
  import TelegramBot.Gettext

  use TelegramBot.Router
  use TelegramBot.Commander

  alias ManulSearch.ManualQuery
  alias TelegramBot.{ManualStruct, SearchResultsWrapper, RedisStore}

  @default_locale Gettext.get_locale(TelegramBot.Gettext)

  command ["start", "help"] do
    user_id = update.message.from.id

    locale = RedisStore.get_user_locale(user_id)
    Gettext.put_locale(TelegramBot.Gettext, locale)

    case send_message gettext "help" do
      {:ok, _} -> nil
      {:error, %Model.Error{reason: reason}} ->
        Logger.log :error, "Reason: #{reason}"
    end
  end

  command "language" do
    {:ok, _} = send_message "Please, choose your language:",
      reply_markup: %Model.InlineKeyboardMarkup{
        inline_keyboard: [
          [
            %{
              callback_data: "/set_language en",
              text: "English",
            },
            %{
              callback_data: "/set_language de",
              text: "German",
            },
          ],
          [
            %{
              callback_data: "/set_language es",
              text: "Spanish",
            },
            %{
              callback_data: "/set_language fr",
              text: "French",
            },
          ],
          [
            %{
              callback_data: "/set_language it",
              text: "Italian",
            },
            %{
              callback_data: "/set_language pt",
              text: "Portuguese",
            },
          ],
          [
            %{
              callback_data: "/set_language ru",
              text: "Russian",
            },
            %{
              callback_data: "/set_language ko",
              text: "Korean",
            },
          ],
          [
            %{
              callback_data: "/set_language ja",
              text: "Japanese",
            },
            %{
              callback_data: "/set_language zh",
              text: "Chinese",
            },
          ]
        ]
      }
  end

  callback_query_command "set_language" do
    locale = case update.callback_query.data do
      "/set_language " <> loc -> loc
    end

    unless Enum.member?(TelegramBot.Gettext.available_locales, locale) do
      locale = @default_locale
    end

    user_id = update.callback_query.from.id

    RedisStore.set_user_locale(user_id, locale)
    Gettext.put_locale(TelegramBot.Gettext, locale)

    case send_message gettext "help" do
      {:ok, _} -> nil
      {:error, %Model.Error{reason: reason}} ->
        Logger.log :error, "Reason: #{reason}"
    end
  end

  inline_query do
    user_id = update.inline_query.from.id

    locale = RedisStore.get_user_locale(user_id)

    query = update.inline_query.query |> String.trim
    manuals_list = ManualQuery.search query, locale

    results = manuals_list["hits"]
      |> Enum.take(20)
      |> Enum.map(&ManualStruct.create/1)
      |> Enum.map(&SearchResultsWrapper.manual_to_inline_query_result/1)

    case answer_inline_query(results) do
      :ok -> nil
      {:error, %Model.Error{reason: reason}} ->
        Logger.log :error, "Errored with query '#{query}'"
        Logger.log :error, "Reason: #{reason}"
    end
  end

  message do
    query = update.message.text |> String.trim

    case ManualQuery.search(query, @default_locale) do
      %{"total" => 0} -> send_message("Nothing found")
      %{"total" => total, "hits" => data} ->
        result = hd(data)
        manual = ManualStruct.create(result)
        link = SearchResultsWrapper.url(manual.id)
        send_message link

        search_url = URI.parse("http://manualsbrain.com/en/search/")
        query_encoded = URI.encode_query(%{q: query})
        link_to_results = put_in search_url.query, query_encoded
          |> to_string()

        send_message "See all results: #{link_to_results}"
    end
  end
end
