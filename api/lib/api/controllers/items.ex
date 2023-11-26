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
        product
        |> Utils.schema_to_map([:user, :user_id, :category])
        |> Map.put(:category, Utils.schema_to_map(product.category, [:products]))
      end)

    Router.json_resp(:ok, conn, products, 200)
  end

  def create_product(%{body_params: body_params, assigns: assigns} = conn) do
    params = Utils.extract_fields(Products.fields(), body_params)

    category =
      body_params
      |> Map.get("category")
      |> Items.get_category()

    user = assigns[:current_user]

    if category do
      case Items.create_product(user, category, params) do
        {:ok, product} ->
          formatted_product =
            product
            |> Utils.schema_to_map([:user_id, :user, :category, :category_id])
            |> Map.merge(%{
              user: Utils.schema_to_map(user, [:products]),
              category: Utils.schema_to_map(product.category, [:products])
            })

          Router.json_resp(:ok, conn, formatted_product, 201)

        {:error, changeset} ->
          Router.json_resp(:error, conn, Utils.changeset_error_to_map(changeset), 400)
      end
    else
      Router.json_resp(:error, conn, "This category doesn't exist yet!", 400)
    end
  end
end
