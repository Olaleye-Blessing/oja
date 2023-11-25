defmodule Api.Controllers.Auth do
  @moduledoc false

  alias Api.Router
  alias Api.Dbs.User
  alias Api.Utils

  def signup(conn) do
    %{body_params: body_params} = conn

    params = %{
      username: Map.get(body_params, "username"),
      email: Map.get(body_params, "email"),
      password: Map.get(body_params, "password")
    }

    case User.register(params) do
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
         {:ok, user} <- User.login(login_params) do
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
    with {:ok, new_user} <- User.update_refresh_token(user, generate_token(user)) do
      access_token = generate_token(user)
      refresh_token = new_user.refresh_token

      Router.json_resp(
        :ok,
        conn,
        %{
          user: Utils.schema_to_map(new_user, [:password, :refresh_token, :products]),
          tokens: %{
            access_token: access_token,
            refresh_token: refresh_token
          }
        },
        200
      )
    else
      {:error, changeset} ->
        Router.json_resp(
          :error,
          conn,
          %{message: Utils.changeset_error_to_map(changeset)},
          400
        )

      _ ->
        Router.json_resp(:error, conn, "Service unavailable! Please try again later", 500)
    end
  end
end
