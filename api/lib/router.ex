defmodule Api.Router do
  use Plug.Router

  import Api.Plugs.Authentication

  alias Api.Routers.{Accounts, Items}

  plug(CORSPlug, origin: ["http://localhost:3000"])
  # see incoming requests in the shell while testing
  plug(Plug.Logger)

  plug(:load_cookies)
  plug(:get_current_user)

  # tells plug to match incoming request to our endpoints
  plug(:match)

  # parse the request if it matches "application/json"
  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  # dispatch the connection the handlers
  plug(:dispatch)

  forward("/api/auth", to: Accounts)

  forward("/api/products", to: Items)

  match _ do
    send_resp(conn, 404, "Resource not found")
  end

  @doc """
  Set the response type of a route to application/json.
  """
  def json_resp(:error, conn, body, status) do
    conn |> json_resp(%{status: status, message: body}, status)
  end

  def json_resp(:ok, conn, body, status) do
    conn |> json_resp(body, status)
  end

  defp json_resp(conn, body, status) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(status, Jason.encode!(body))
  end

  @doc """
  Adds cookies to the response.
  """
  def add_cookies(conn, cookies) do
    Enum.reduce(cookies, conn, fn {name, value, opts}, conn ->
      conn
      |> Plug.Conn.put_resp_cookie(name, value, opts)
    end)
  end

  @doc """
  Loads cookies from the request and assigns them to the connection.
  """
  def load_cookies(conn, _opts) do
    conn
    |> Plug.Conn.fetch_cookies()
  end
end
