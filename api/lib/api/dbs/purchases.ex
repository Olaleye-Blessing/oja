defmodule Api.Dbs.Purchases do
  @moduledoc false

  alias Ecto.Multi
  alias Api.Repo
  alias Api.Dbs.Purchases.Purchases, as: PurchasesSchema
  alias Api.Dbs.Items
  alias Api.Dbs.Items.Products

  def create_purchase_info(%{products: products} = params) do
    Enum.reduce(products, Multi.new(), fn product, multi ->
      product_id = Map.get(product, :product_id)

      db_product = Items.get_product(product_id, [])

      db_product_changeset =
        Products.changeset(db_product, %{
          stock_quantity: db_product.stock_quantity - Map.get(product, :quantity)
        })

      Multi.update(
        multi,
        {:product, product_id},
        db_product_changeset
      )
    end)
    |> Multi.insert(:purchase, PurchasesSchema.changeset(%PurchasesSchema{}, params))
    |> Repo.transaction()
  end
end
