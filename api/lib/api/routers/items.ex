defmodule Api.Routers.Items do
  @moduledoc false
  use Plug.Router

  import Api.Plugs.Authentication

  alias Api.Controllers.Items, as: ItemsController

  plug(:authenticated, %{products: true})

  plug(:match)
  plug(:dispatch)

  get "/" do
    ItemsController.get_all_products(conn)
  end

  get "/:id" do
    ItemsController.get_product(conn)
  end

  post "/" do
    ItemsController.create_product(conn)
  end

  get "/categories", init_opts: [parent: :categories] do
    ItemsController.get_categories(conn)
  end
end
