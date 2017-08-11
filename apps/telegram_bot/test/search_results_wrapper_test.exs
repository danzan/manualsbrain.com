defmodule TelegramBot.SearchResultsWrapperTest do
  use ExUnit.Case

  test "returns an article struct" do
    m = %TelegramBot.ManualStruct{
      brand: "HP",
      category: "Printers",
      id: "3505",
      manual_type: "Leaflet",
      name: "10 Cyan"
    }

    assert TelegramBot.SearchResultsWrapper.manual_to_inline_query_result(m) == %Nadia.Model.InlineQueryResult.Article{
      description: "HP | Printers | Leaflet",
      hide_url: nil,
      id: "3505",
      input_message_content: %{message_text: "http://manualsbrain.com/en/manuals/3505"},
      reply_markup: nil,
      thumb_height: nil,
      thumb_url: nil,
      thumb_width: nil,
      title: "10 Cyan",
      type: "article",
      url: nil
    }
  end
end
