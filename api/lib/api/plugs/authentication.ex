defmodule Api.Plugs.Authentication do
  @moduledoc false

  import Plug.Conn

  alias Api.Dbs.User

  @doc """
  Saves the authenticated user in the assigns key.
  Other subsequent plugs will have access to the user.
  """
  def get_current_user(conn, _opts) do
    with {:ok, token} <- get_token(conn),
         {:ok, user_id} <- verify_token(token) do
      user = User.get(user_id)

      assign(conn, :current_user, user)
    else
      _ -> assign(conn, :current_user, nil)
    end
  end

  @doc """
  Protects routes to ensure they are only accessible by authenticated users.
  If a user is not authenticated, a JSON response with an unauthorized status code (401) will be returned, prompting the user to log in again.
  """
  def authenticated(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
    else
      conn = halt(conn)
      Api.Router.json_resp(:error, conn, "Unauthorized! Please log in again!", 401)
    end
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
