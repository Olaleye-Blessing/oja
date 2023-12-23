defmodule Api.Routers.Order do
  @moduledoc """
  This module contains the routes for the order endpoints.
  It is responsible for dispatching the connection to the order' controller.
  """

  use Plug.Router

  import(Api.Plugs.Authentication)

  alias Api.Controllers.Order

  plug(:authenticated, %{orders: true})

  plug(:match)
  plug(:dispatch)

  post "/" do
    Order.create(conn)
  end
end
