defmodule Api.Dbs.Cart do
  @moduledoc false

  alias Ecto.Multi
  alias Api.Repo
  alias Api.Dbs.Cart.Purchase
  alias Api.Dbs.Catalog
  alias Api.Dbs.Catalog.Product

  @doc """
  Create a purchase(cart).

  The products stock_quantity will be updated for each product in the cart.

  ## Examples

        iex> Api.Dbs.Cart.create(%{products: [%{product_id: 1, quantity: 1}], shipping_address: %{}, user_id: 1, total_price: 100, status: "pending"})
        {:ok, %Purchase{}}
  """
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
