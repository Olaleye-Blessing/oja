defmodule Api.Routers.Cart do
  @moduledoc """
  This module contains the routes for the cart endpoints.
  It is responsible for dispatching the connection to the cart' controller.
  """

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
