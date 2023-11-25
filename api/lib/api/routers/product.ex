defmodule Api.Routers.Product do
  @moduledoc false
  use Plug.Router

  import Api.Plugs.Authentication

  alias Api.Controllers.Product, as: ProductController

  plug(:authenticated, %{products: true})

  plug(:match)
  plug(:dispatch)

  get "/" do
    ProductController.get_all(conn)
  end

  post "/" do
    ProductController.create(conn)
  end
end
