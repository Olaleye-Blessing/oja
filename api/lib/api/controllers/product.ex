defmodule Api.Controllers.Product do
  @moduledoc false

  alias Api.Router
  alias Api.Utils
  alias Api.Dbs.Product, as: ProductDB

  alias Api.Dbs.Schemas.Product, as: ProductSchema

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
