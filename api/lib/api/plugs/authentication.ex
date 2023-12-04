defmodule Api.Plugs.Authentication do
  @moduledoc """
  This module contains the plugs responsible for authenticating the user.
  It contains the plugs that protect routes from unauthenticated users.
  """

  import Plug.Conn

  alias Api.Dbs.Accounts

  @common_protected_paths ["POST", "PUT", "DELETE"]

  @doc """
  Saves the authenticated user in the assigns key.
  Other subsequent plugs will have access to the user.
  """
  @spec get_current_user(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def get_current_user(conn, _opts) do
    with {:ok, token} <- get_token(conn),
         {:ok, user_id} <- verify_token(token) do
      user = Accounts.get(user_id)

      assign(conn, :current_user, user)
    else
      _ -> assign(conn, :current_user, nil)
    end
  end

  @doc """
  Protects routes to ensure they are only accessible by authenticated users.
  It uses the second argument to determine which routes to protect.

  If a user is not authenticated, a JSON response with an unauthorized status code (401) will be returned, prompting the user to log in again.
  """
  @spec authenticated(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def authenticated(conn, %{products: _}), do: protect_auth_path(conn, @common_protected_paths)
  def authenticated(conn, %{purchases: _}), do: protect_auth_path(conn, ["POST"])
  def authenticated(conn, _opts), do: conn

  defp protect_auth_path(conn, methods) do
    if Map.get(conn, :method) in methods do
      is_authenticated(conn)
    else
      conn
    end
  end

  defp is_authenticated(conn) do
    if conn.assigns[:current_user] do
      conn
    else
      conn = halt(conn)
      Api.Router.json_resp(:error, conn, "Unauthorized! Please log in again!", 401)
    end
  end

  # TODO: We might later move to cookies based authentication
  defp get_token(%{cookies: %{"access_token" => access_token}} = _conn) do
    {:ok, access_token}
  end

  defp get_token(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] -> {:ok, token}
      _ -> {:error, "unauthenticated"}
    end
  end

  defp verify_token(token) do
    case Api.Token.verify_and_validate(token) do
      {:ok, %{"user_id" => user_id}} ->
        {:ok, user_id}

      {:error, _} ->
        {:error, "Invalid token"}
    end
  end
end
