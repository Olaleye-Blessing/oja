defmodule Api.Routers.Purchases do
  @moduledoc false

  use Plug.Router

  import(Api.Plugs.Authentication)

  alias Api.Controllers.Purchases, as: PurchasesController

  plug(:authenticated, %{purchases: true})

  plug(:match)
  plug(:dispatch)

  post "/" do
    PurchasesController.create_purchase(conn)
  end
end
