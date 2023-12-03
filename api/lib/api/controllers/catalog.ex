defmodule Api.Controllers.Catalog do
  @moduledoc false

  alias Api.Router
  alias Api.Utils
  alias Api.Dbs.Catalog

  alias Api.Dbs.Catalog.Product

  def get_all_products(conn) do
    products =
      Catalog.list_products()
      |> Enum.map(fn product ->
        product
        |> Utils.schema_to_map([:user, :user_id, :category])
        |> Map.put(:category, Utils.schema_to_map(product.category, [:products]))
      end)

    Router.json_resp(:ok, conn, products, 200)
  end

  def get_product(%{path_params: %{"id" => id}} = conn) do
    case Integer.parse(id) do
      :error ->
        Router.json_resp(:error, conn, "Please provide a valid product ID", 400)

      {id, _} ->
        product = Catalog.get_product(id)

        if product do
          category = Utils.schema_to_map(product.category, [:products])
          user = Utils.schema_to_map(product.user, [:products, :password, :purchases])
          formatted_product = Utils.schema_to_map(product, [:category, :user])

          Router.json_resp(
            :ok,
            conn,
            Map.merge(formatted_product, %{user: user, category: category}),
            200
          )
        else
          Router.json_resp(:error, conn, "Product does not exist", 400)
        end
    end
  end

  def get_product(conn) do
    Router.json_resp(:error, conn, "Please provide a product ID", 400)
  end

  def create_product(%{body_params: body_params, assigns: assigns} = conn) do
    params = Utils.extract_fields(Product.fields(), body_params)

    category =
      body_params
      |> Map.get("category")
      |> Catalog.get_category()

    user = assigns[:current_user]

    if category do
      case Catalog.create_product(user, category, params) do
        {:ok, product} ->
          formatted_product =
            product
            |> Utils.schema_to_map([:user_id, :user, :category, :category_id])
            |> Map.merge(%{
              user: Utils.schema_to_map(user, [:products, :purchases]),
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

  def get_categories(conn) do
    Router.json_resp(
      :ok,
      conn,
      Catalog.list_categories()
      |> Enum.map(&Utils.schema_to_map(&1, [:products])),
      200
    )
  end
end
