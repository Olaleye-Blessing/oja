defmodule Api.Routers.CurrencyConverter do
  @moduledoc false

  use Plug.Router

  alias Api.Controllers.CurrencyConverter, as: Controller

  plug(:match)
  plug(:dispatch)

  get "/" do
    Controller.get_curriencies(conn)
  end

  get "/convert" do
    Controller.convert(conn)
  end
end
