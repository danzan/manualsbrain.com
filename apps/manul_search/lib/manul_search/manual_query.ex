defmodule ManulSearch.ManualQuery do
  @default_locale "en"

  def search(query, locale) do
    data = prepared(query, locale)
    search_in = ["manual"]

    {:ok, response} = ManulSearch.Elastix.search(search_in, %{query: data})
    response.body["hits"]
  end

  defp prepared(query, locale) do
    downcased_query = String.downcase query
    params = [
      %{ match: %{ "uniq_product_name.generic": %{
        query: downcased_query,
        boost: 3
      } } },
      %{ match: %{ "uniq_product_name.trigram": %{
        query: downcased_query,
        minimum_should_match: "50%",
        boost: 1
      } } }
    ]

    default_locale_json = %{
      match: %{
        "material_type.translations.#{@default_locale}.name.analyzed": %{
          query: query
        }
      }
    }

    unless locale == @default_locale do
      params = [default_locale_json | params]
    end

    %{
      bool: %{
        should: params
      }
    }
  end
end
