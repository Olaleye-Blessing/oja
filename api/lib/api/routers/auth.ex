defmodule API.Routers.Auth do
  use Plug.Router

  alias API.Router
  alias API.Dbs.User
  alias Api.Utils

  plug(:match)
  plug(:dispatch)

  post "/signup" do
    %{body_params: body_params} = conn

    params = %{
      username: Map.get(body_params, "username"),
      email: Map.get(body_params, "email"),
      password: Map.get(body_params, "password")
    }

    case User.register(params) do
      {:ok, user} ->
        Router.json_resp(conn, %{user: Utils.schema_to_map(user, [:password])})

      {:error, changeset} ->
        Router.json_resp(
          conn,
          %{error: Utils.changeset_error_to_map(changeset)},
          400
        )
    end
  end
end
