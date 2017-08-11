defmodule ManulSearch.ManualQueryTest do
  use ExUnit.Case

  test "search for manuals" do
    assert ManulSearch.ManualQuery.search("test", nil) == %{"total" => 0, "hits" => [], "max_score" => nil}
  end
end
