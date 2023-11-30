defmodule Api.Controllers.Accounts do
  @moduledoc false

  alias Api.Router
  alias Api.Dbs.Accounts
  alias Api.Utils

  @cookie_opts [
    path: "/",
    http_only: Application.get_env(:api, :env) == :prod,
    secure: Application.get_env(:api, :env) == :prod
  ]

  def signup(conn) do
    %{body_params: body_params} = conn

    params = %{
      username: Map.get(body_params, "username"),
      email: Map.get(body_params, "email"),
      password: Map.get(body_params, "password")
    }

    case Accounts.register(params) do
      {:ok, user} ->
        authenticate_user(conn, user)

      {:error, changeset} ->
        Router.json_resp(
          :error,
          conn,
          Utils.changeset_error_to_map(changeset),
          400
        )
    end
  end

  def login(conn) do
    %{body_params: body_params} = conn

    login_params = %{
      email: Map.get(body_params, "email"),
      password: Map.get(body_params, "password")
    }

    with {:ok, _} <- validate_login_params(login_params),
         {:ok, user} <- Accounts.login(login_params) do
      authenticate_user(conn, user)
    else
      {:error, msg} ->
        Router.json_resp(:error, conn, msg, 401)
    end
  end

  defp validate_login_params(%{email: nil, password: nil}),
    do: {:error, "Please provide email and password"}

  defp validate_login_params(%{email: nil, password: _}), do: {:error, "Please provide email"}
  defp validate_login_params(%{email: "", password: _}), do: {:error, "Please provide email"}
  defp validate_login_params(%{email: _, password: nil}), do: {:error, "Please provide password"}
  defp validate_login_params(%{email: _, password: ""}), do: {:error, "Please provide password"}
  defp validate_login_params(_params), do: {:ok, true}

  defp generate_token(user) do
    Api.Token.generate_and_sign!(%{"user_id" => user.id})
  end

  defp authenticate_user(conn, user) do
    refresh_token = Accounts.get_user_refresh_token(user)

    refresh_token =
      if refresh_token do
        # TODO: Update this logic:
        # to check if the refresh token is expired
        # if it is, generate a new one
        refresh_token.token
      else
        Accounts.generate_refresh_token(user)
      end

    access_token = generate_token(user)

    Router.json_resp(
      :ok,
      conn
      |> Router.add_cookies([
        {"refresh_token", refresh_token, [max_age: 3600 * 24 * 30] ++ @cookie_opts},
        {"access_token", access_token, [max_age: Api.Token.expiry()] ++ @cookie_opts}
      ]),
      %{
        user: Utils.schema_to_map(user, [:password, :products]),
        tokens: %{
          access_token: access_token,
          refresh_token: refresh_token
        }
      },
      200
    )
  end
end
