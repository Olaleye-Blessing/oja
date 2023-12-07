defmodule Api.Routers.Catalog do
  @moduledoc """
  This module contains the routes for the catalog endpoints.
  It is responsible for dispatching the connection to the catalog' controller.
  """
  use Plug.Router

  import Api.Plugs.Authentication

  alias Api.Controllers.Catalog, as: CatalogController

  plug(:authenticated, %{products: true, watchlists: true})

  plug(:match)
  plug(:dispatch)

  get "/categories", init_opts: [parent: :categories] do
    CatalogController.get_categories(conn)
  end

  get "/" do
    CatalogController.get_all_products(conn)
  end

  get "/:id" do
    CatalogController.get_product(conn)
  end

  post "/:id/watchlist" do
    CatalogController.add_product_to_watchlist(conn)
  end

  delete "/:id/watchlist" do
    CatalogController.remove_product_from_watchlist(conn)
  end

  post "/" do
    CatalogController.create_product(conn)
  end

  match _ do
    send_resp(conn, 404, "Resource not found")
  end
end
