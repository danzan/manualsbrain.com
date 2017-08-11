defmodule ManulSearch.Elastix do
  def elastic_url do
    Application.get_env(:manul_search, :elastic_url)
  end

  def index_name do
    Application.get_env(:manul_search, :elastic_index)
  end

  def search(search_in, data) do
    Elastix.Search.search(elastic_url(), index_name(), search_in, data)
  end
end
