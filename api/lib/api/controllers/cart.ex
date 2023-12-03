defmodule Api.Controllers.Cart do
  @moduledoc false

  alias Api.Router
  alias Api.Utils
  alias Api.Dbs.Cart.{ShippingAddress}
  alias Api.Dbs.Catalog
  alias Api.Dbs.Cart

  def create_purchase(%{body_params: body_params, assigns: %{current_user: user}} = conn) do
    products =
      body_params["products"]
      |> Enum.map(fn product ->
        Utils.extract_fields([:product_id, :quantity], product)
      end)

    with {:ok, total_price, new_products} <- get_total_price(products),
         {:ok, shipping_address} <- get_shipping_address(body_params["shipping_address"]) do
      purchase_info = %{
        status: "pending",
        user_id: user.id,
        shipping_address: shipping_address,
        products: new_products,
        total_price: total_price
      }

      case Cart.create(purchase_info) do
        {:ok, _info} ->
          IO.inspect("____ 🔥 Success _____")
          # TODO: send a confirmation email in the future
          Router.json_resp(
            :ok,
            conn,
            "#{user.username}, Thank you for your order from Oja-nla. Once your package shipped we will send you a tracking number. You can check the status of your order by logging into your account.",
            200
          )

        {:error, _changeset} ->
          IO.inspect("____ 🔥 Error _____")
          Router.json_resp(:error, conn, "Unknown error! Try again later", 400)
      end
    else
      # key can be :products or :shipping_address at the moment
      {:error, key, msg} ->
        Router.json_resp(:error, conn, %{key => msg}, 400)

      _ ->
        Router.json_resp(:error, conn, "Unknown error! Try again later", 400)
    end
  end

  defp get_total_price(products) do
    {error, total_price, new_products} =
      products
      |> Enum.reduce({%{}, 0, []}, fn %{product_id: product_id, quantity: quantity},
                                      {error, total_price, new_products} ->
        case Catalog.get_product(product_id, []) do
          nil ->
            {update_price_error(error, product_id, "Product not found"), total_price,
             new_products}

          product ->
            if quantity > product.stock_quantity do
              {update_price_error(
                 error,
                 product_id,
                 "Only #{product.stock_quantity} units are available"
               ), total_price, new_products}
            else
              {error, update_total_price(total_price, product, quantity),
               [
                 %{
                   quantity: quantity,
                   price: product.price,
                   product_id: product_id
                 }
                 | new_products
               ]}
            end
        end
      end)

    if Enum.count(error) > 0 do
      {:error, :products, error}
    else
      {:ok, total_price, new_products}
    end
  end

  defp update_total_price(total_price, product, quantity) do
    product_price = product.price |> Decimal.mult(quantity) |> Decimal.to_float()

    (total_price * 100 + product_price * 100) / 100
  end

  defp update_price_error(error, product_id, msg) do
    Map.put(error, product_id, msg)
  end

  defp get_shipping_address(params) do
    address = Utils.extract_fields(ShippingAddress.fields(), params)

    changeset = ShippingAddress.changeset(%ShippingAddress{}, address)

    if changeset.valid? do
      {:ok, address}
    else
      {:error, :shipping_address, Utils.changeset_error_to_map(changeset)}
    end
  end
end
