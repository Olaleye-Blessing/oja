defmodule Api.Routers.Accounts do
  @moduledoc """
  This module contains the routes for the accounts endpoints.
  It is responsible for dispatching the connection to the accounts' controller.
  """
  use Plug.Router

  import(Api.Plugs.Authentication)

  alias Api.Controllers.Accounts, as: AccountsController

  plug(:authenticated, %{accounts: true})
  plug(:match)
  plug(:dispatch)

  post "/signup" do
    AccountsController.signup(conn)
  end

  post "/login" do
    AccountsController.login(conn)
  end

  delete "/logout" do
    AccountsController.logout(conn)
  end
end
