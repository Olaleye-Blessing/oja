defmodule Api.Router do
  use Plug.Router

  alias Api.Routers.{Auth}

  plug(CORSPlug, origin: "*")
  # see incoming requests in the shell while testing
  plug(Plug.Logger)

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

  get "/api" do
    json_resp(:ok, conn, %{message: "Welcome to the API"}, 200)
  end

  forward("/api/auth", to: Auth)

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
end
