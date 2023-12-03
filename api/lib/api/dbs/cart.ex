defmodule Api.Dbs.Cart do
  @moduledoc false

  alias Ecto.Multi
  alias Api.Repo
  alias Api.Dbs.Cart.Purchase
  alias Api.Dbs.Catalog
  alias Api.Dbs.Catalog.Product

  def create(%{products: products} = params) do
    Enum.reduce(products, Multi.new(), fn product, multi ->
      product_id = Map.get(product, :product_id)

      db_product = Catalog.get_product(product_id, [])

      db_product_changeset =
        Product.changeset(db_product, %{
          stock_quantity: db_product.stock_quantity - Map.get(product, :quantity)
        })

      Multi.update(
        multi,
        {:product, product_id},
        db_product_changeset
      )
    end)
    |> Multi.insert(:purchase, Purchase.changeset(%Purchase{}, params))
    |> Repo.transaction()
  end
end
