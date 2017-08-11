defmodule TelegramBot.SearchResultsWrapper do
  def manual_to_inline_query_result(m) do
    %Nadia.Model.InlineQueryResult.Article{
      id: m.id,
      title: m.name,
      description: description(m),
      thumb_url: m.thumbnail_url,
      input_message_content: %{
        message_text: url(m.id)
      }
    }
  end

  def url(id) do
    "http://manualsbrain.com/en/manuals/" <> id
  end

  defp description(m) do
    brand = to_string(m.brand)
    category = to_string(m.category)
    manual_type = to_string(m.manual_type)

    brand <> " | " <> category <> " | " <> manual_type
  end
end