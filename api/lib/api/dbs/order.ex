defmodule Api.Dbs.Order do
  @moduledoc false

  alias Ecto.Multi
  alias Api.Repo
  alias Api.Dbs.Order.Order
  alias Api.Dbs.Catalog
  alias Api.Dbs.Catalog.Product

  @doc """
  Create an order.

  The products stock_quantity will be updated for each product in the order.

  ## Examples

        iex> Api.Dbs.Order.create(%{products: [%{product_id: 1, quantity: 1}], shipping_address: %{}, user_id: 1, total_price: 100, status: "pending"})
        {:ok, %Order{}}
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
    |> Multi.insert(:purchase, Order.changeset(%Order{}, params))
    |> Repo.transaction()
  end
end
