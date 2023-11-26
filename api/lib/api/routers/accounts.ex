defmodule Api.Routers.Accounts do
  # Api.Routers.Auth
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
