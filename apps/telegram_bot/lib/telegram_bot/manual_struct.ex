defmodule TelegramBot.ManualStruct do
  defstruct id: nil,
            name: nil,
            brand: nil,
            category: nil,
            manual_type: nil,
            thumbnail_url: nil
  use ExConstructor

  def create(manual) do
    new(
      %{"id" => manual["_id"],
        "name" => manual["_source"]["product_name"],
        "brand" => manual["_source"]["brand"]["name"],
        "category" => manual["_source"]["category"]["translations"]["en"]["name"],
        "manual_type" => manual["_source"]["material_type"]["translations"]["en"]["name"],
        "thumbnail_url" => manual["_source"]["thumbnail_url"]
      }
    )
  end
end
