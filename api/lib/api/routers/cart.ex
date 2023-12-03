defmodule Api.Routers.Cart do
  @moduledoc false

  use Plug.Router

  import(Api.Plugs.Authentication)

  alias Api.Controllers.Cart, as: CartController

  plug(:authenticated, %{purchases: true})

  plug(:match)
  plug(:dispatch)

  post "/" do
    CartController.create_purchase(conn)
  end
end
