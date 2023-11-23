defmodule Api.Routers.Auth do
  use Plug.Router

  alias Api.Controllers.Auth, as: AuthController

  plug(:match)
  plug(:dispatch)

  post "/signup" do
    AuthController.signup(conn)
  end

  post "login" do
    AuthController.login(conn)
  end
end
