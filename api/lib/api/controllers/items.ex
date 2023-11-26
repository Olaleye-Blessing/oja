defmodule Api.Controllers.Items do
  @moduledoc false

  alias Api.Router
  alias Api.Utils
  alias Api.Dbs.Items

  alias Api.Dbs.Items.Products

  def get_all_products(conn) do
    products =
      Items.list_products()
      |> Enum.map(fn product ->
        Utils.schema_to_map(product, [:user, :user_id])
      end)

    IO.inspect(products)

    Router.json_resp(:ok, conn, products, 200)
  end

  def create_product(%{body_params: body_params, assigns: assigns} = conn) do
    params = Utils.extract_fields(Products.fields(), body_params)

    case Items.create_product(assigns[:current_user], params) do
      {:ok, product} ->
        IO.inspect(product)

        Router.json_resp(:ok, conn, Utils.schema_to_map(product, [:user_id, :user]), 201)

      {:error, changeset} ->
        Router.json_resp(:error, conn, Utils.changeset_error_to_map(changeset), 400)
    end
  end
end
