defmodule Api.Routers.Accounts do
  @moduledoc """
  This module contains the routes for the accounts endpoints.
  It is responsible for dispatching the connection to the accounts' controller.
  """
  use Plug.Router

  alias Api.Controllers.Accounts, as: AccountsController

  plug(:match)
  plug(:dispatch)

  post "/signup" do
    AccountsController.signup(conn)
  end

  post "login" do
    AccountsController.login(conn)
  end
end
