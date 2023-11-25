defmodule Api.Controllers.Product do
  @moduledoc false

  alias Api.Router
  alias Api.Utils
  alias Api.Dbs.Product, as: ProductDB

  alias Api.Dbs.Schemas.Product, as: ProductSchema

  def get_all(conn) do
    # products =
    #   ProductDB.all()
    #   |> Enum.map(fn product ->
    #     user = Utils.schema_to_map(product.user, [:password, :refresh_token, :products])
    #     new_product = Utils.schema_to_map(product, [:user])

    #     Map.put(new_product, :user, user)
    #   end)

    products =
      ProductDB.all()
      |> Enum.map(fn product ->
        Utils.schema_to_map(product, [:user, :user_id])
      end)

    IO.inspect(products)

    Router.json_resp(:ok, conn, products, 200)
  end

  def create(%{body_params: body_params, assigns: assigns} = conn) do
    params = Utils.extract_fields(ProductSchema.fields(), body_params)

    case ProductDB.create(assigns[:current_user], params) do
      {:ok, product} ->
        IO.inspect(product)

        Router.json_resp(:ok, conn, Utils.schema_to_map(product, [:user_id, :user]), 201)

      {:error, changeset} ->
        Router.json_resp(:error, conn, Utils.changeset_error_to_map(changeset), 400)
    end
  end
end
