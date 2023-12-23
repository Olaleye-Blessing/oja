defmodule Api.Controllers.Catalog do
  @moduledoc false

  alias Api.Router
  alias Api.Utils
  alias Api.Dbs.Catalog

  alias Api.Dbs.Catalog.Product

  @doc """
  Returns all products.
  """
  @spec get_all_products(Plug.Conn.t()) :: Plug.Conn.t()
  def get_all_products(%{query_params: query_params} = conn) do
    search_params =
      Utils.extract_fields([:name, :price_from, :price_to, :condition, :category], query_params)

    search_params =
      search_params
      |> Map.put(:price, %{
        from: Map.get(search_params, :price_from, nil),
        to: Map.get(search_params, :price_to, nil)
      })
      |> Map.drop([:price_from, :price_to])

    products =
      Catalog.list_products(search_params)
      |> Enum.map(fn product ->
        product
        |> Utils.schema_to_map([:user, :user_id, :category])
        |> Map.put(:category, Utils.schema_to_map(product.category, [:products]))
      end)

    Router.json_resp(:ok, conn, products, 200)
  end

  @doc """
  Returns a product with the given ID.

  If the product doesn't exist or product ID is not a valid integer, a JSON response with a bad request status code (400) will be returned.
  """
  @spec get_product(Plug.Conn.t()) :: Plug.Conn.t()
  def get_product(%{path_params: %{"id" => id}} = conn) do
    case Integer.parse(id) do
      :error ->
        Router.json_resp(:error, conn, "Please provide a valid product ID", 400)

      {id, _} ->
        product = Catalog.get_product(id)

        if product do
          category = Utils.schema_to_map(product.category, [:products])

          user =
            Utils.schema_to_map(product.user, [
              :products,
              :password,
              :orders,
              :watched_products
            ])

          watchers =
            product.watchers
            |> Enum.map(
              &Utils.schema_to_map(&1, [
                :products,
                :password,
                :orders,
                :watched_products
              ])
            )

          formatted_product = Utils.schema_to_map(product, [:category, :user, :watchers])

          Router.json_resp(
            :ok,
            conn,
            Map.merge(formatted_product, %{user: user, category: category, watchers: watchers}),
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

  @doc """
  Creates a new product.
  """
  @spec create_product(Plug.Conn.t()) :: Plug.Conn.t()
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
            |> Utils.schema_to_map([:user_id, :user, :category, :category_id, :watchers])
            |> Map.merge(%{
              user: Utils.schema_to_map(user, [:products, :orders, :watched_products]),
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

  @doc """
  Gets all categories.
  """
  @spec get_categories(Plug.Conn.t()) :: Plug.Conn.t()
  def get_categories(conn) do
    Router.json_resp(
      :ok,
      conn,
      Catalog.list_categories()
      |> Enum.map(&Utils.schema_to_map(&1, [:products])),
      200
    )
  end

  @doc """
  Add product to watch list
  """
  def add_product_to_watchlist(
        %{assigns: %{current_user: user}, params: %{"id" => product_id}} = conn
      ) do
    product = Catalog.get_product(product_id, [])

    if product do
      case Catalog.watch_product(user, product) do
        {:ok, _result} ->
          Router.json_resp(:ok, conn, "Successfully added!", 200)

        {:error, changeset} ->
          Router.json_resp(:error, conn, Utils.changeset_error_to_map(changeset), 400)
      end
    else
      Router.json_resp(:error, conn, "This product no longer exists.", 200)
    end
  end

  def remove_product_from_watchlist(
        %{assigns: %{current_user: user}, params: %{"id" => product_id}} = conn
      ) do
    Catalog.unwatch_product(user.id, product_id)

    Router.json_resp(:ok, conn, "Successfully unwatched product", 200)
  end
end
