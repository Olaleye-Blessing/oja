defmodule Api.Plugs.Authentication do
  @moduledoc false

  import Plug.Conn

  alias Api.Dbs.Accounts

  @doc """
  Saves the authenticated user in the assigns key.
  Other subsequent plugs will have access to the user.
  """
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
  If a user is not authenticated, a JSON response with an unauthorized status code (401) will be returned, prompting the user to log in again.
  """
  def authenticated(conn, %{products: _}) do
    protected_methods = ["POST", "PUT", "DELETE"]
    conn_method = Map.get(conn, :method)

    if conn_method in protected_methods do
      is_authenticated(conn)
    else
      conn
    end
  end

  def authenticated(conn, %{purchases: _}) do
    protected_methods = ["POST"]
    conn_method = Map.get(conn, :method)

    if conn_method in protected_methods do
      is_authenticated(conn)
    else
      conn
    end
  end

  def authenticated(conn, _opts) do
    conn
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
