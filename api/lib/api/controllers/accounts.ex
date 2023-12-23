defmodule Api.Controllers.Accounts do
  @moduledoc """
  This module contains the logic for the accounts endpoints.
  """

  alias Api.Router
  alias Api.Dbs.Accounts
  alias Api.Utils

  @cookie_opts [
    path: "/",
    same_site: "none",
    http_only: Application.get_env(:api, :env) == :prod,
    secure: true
  ]

  @doc """
  Creates a new user.
  If the user is created successfully:
  - A refresh token is generated and stored in the database.
  - An access token is generated
  - The access token and refresh token are stored in cookies and also returned in the json response.
    Note: The refresh and access tokens might be removed from the json response in the future.
  """
  @spec signup(Plug.Conn.t()) :: Plug.Conn.t()
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

  @doc """
  Logs in a user.
  If the user is logged in successfully: (Check signup/1 for more details)
  """
  @spec login(Plug.Conn.t()) :: Plug.Conn.t()
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

  @doc """
  Delete all auth cookies associated with a user
  """
  @spec logout(Plug.Conn.t()) :: Plug.Conn.t()
  def logout(%{assigns: %{current_user: user}} = conn) do
    # TODO: The errors here might not be necessary. Make research on what should be done instead
    case Accounts.delete_user_refresh_token(user) do
      {:ok, _} ->
        Router.json_resp(
          :ok,
          Router.delete_cookies(conn, [
            {"refresh_token", @cookie_opts},
            {"access_token", @cookie_opts}
          ]),
          "",
          204
        )

      {:error, nil} ->
        Router.json_resp(:error, conn, "You were never logged in.", 401)

      _ ->
        Router.json_resp(:error, conn, "Unknown error", 401)
    end
  end

  @doc """
  Update a user password
  """
  @spec update_password(Plug.Conn.t()) :: Plug.Conn.t()
  def update_password(%{assigns: %{current_user: user}, body_params: params} = conn) do
    with {:ok, new_password, current_password} <- get_password_update_params(params),
         {:ok, _} <- validate_current_password(current_password, user),
         {:ok, _result} <- Accounts.update_password(user, new_password) do
      Router.json_resp(:ok, conn, "Password changed successfully!", 200)
    else
      {:error, changeset = %Ecto.Changeset{}} ->
        Router.json_resp(:error, conn, Utils.changeset_error_to_map(changeset), 400)

      {:error, error} ->
        Router.json_resp(:error, conn, error, 400)
    end
  end

  defp validate_current_password(password, user) do
    if Pbkdf2.verify_pass(password, user.password) do
      {:ok, ""}
    else
      {:error, %{current_password: "Current password is incorrect!"}}
    end
  end

  defp get_password_update_params(params) do
    cond do
      Map.get(params, "current_password", nil) == nil ->
        {:error, %{current_password: "Please provide the current password"}}

      Map.get(params, "new_password", nil) == nil ->
        {:error, %{new_password: "Please provide a new password"}}

      true ->
        {:ok, Map.get(params, "new_password"), Map.get(params, "current_password")}
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
        # TODO: Update the path of this refresh token: https://stackoverflow.com/a/61526919
        {"refresh_token", refresh_token, [max_age: 3600 * 24 * 30] ++ @cookie_opts},
        {"access_token", access_token, [max_age: Api.Token.expiry()] ++ @cookie_opts}
      ]),
      %{user: Utils.schema_to_map(user, [:password, :products, :orders, :watched_products])},
      200
    )
  end
end
