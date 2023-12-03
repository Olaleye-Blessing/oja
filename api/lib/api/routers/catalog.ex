defmodule Api.Routers.Catalog do
  @moduledoc false
  use Plug.Router

  import Api.Plugs.Authentication

  alias Api.Controllers.Catalog, as: CatalogController

  plug(:authenticated, %{products: true})

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

  post "/" do
    CatalogController.create_product(conn)
  end
end
