defmodule TelegramBot.ManualStructTest do
  use ExUnit.Case

  test "returns an article struct" do
    manual = %{"_id" => "3505", "_index" => "development_search_1491920317786",
     "_score" => 0.011273997,
     "_source" => %{"brand" => %{"id" => 4800, "name" => "HP"},
       "category" => %{"id" => 1564,
         "translations" => %{"de" => nil, "en" => "Printers", "es" => nil, "fr" => nil,
           "it" => nil, "ja" => nil, "ko" => nil, "pt" => nil, "ru" => nil,
           "zh" => nil}},
       "material_type" => %{"id" => 2180,
         "translations" => %{"de" => %{"name" => "Merkblatt"},
           "en" => %{"name" => "Leaflet"}, "es" => %{"name" => "Prospecto"},
           "fr" => %{"name" => "Fascicule"}, "it" => %{"name" => "Dépliant"},
           "ja" => %{"name" => "プリント"}, "ko" => %{"name" => "전단"},
           "pt" => %{"name" => "Folheto"},
           "ru" => %{"name" => "Листовка"},
           "zh" => %{"name" => "产品宣传页"}}},
       "product_name" => "10 Cyan", "variant" => "C4841AE"},
     "_type" => "manual"}

    assert TelegramBot.ManualStruct.create(manual) == %TelegramBot.ManualStruct{
      brand: "HP",
      category: "Printers",
      id: "3505",
      manual_type: "Leaflet",
      name: "10 Cyan"
    }
  end
end
