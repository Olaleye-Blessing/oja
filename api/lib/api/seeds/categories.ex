defmodule Api.Seeds.Categories do
  @moduledoc """
  Seeds for the Catgeory schema.
  """

  alias Api.Dbs.Catalog

  def seed() do
    Enum.map(categories(), fn category ->
      Catalog.create_category(category) |> IO.inspect()
    end)
  end

  defp categories() do
    [
      %{name: "Phone"},
      %{name: "Book"},
      %{name: "Jewelry"},
      %{name: "Furniture"},
      %{name: "Collectible"},
      %{name: "Clothing"},
      %{name: "Shoe"},
      %{name: "Accessory"},
      %{name: "Necklace"},
      %{name: "Watch"},
      %{name: "Food"},
      %{name: "Video game"},
      %{name: "Art"},
      %{name: "Craft"},
      %{name: "Bag"},
      %{name: "Electronics"},
      %{name: "Car"}
    ]
  end
end
