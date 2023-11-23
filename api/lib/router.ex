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
    json_resp(conn, %{message: "Welcome to the API"})
  end

  forward("/api/auth", to: Auth)

  match _ do
    send_resp(conn, 404, "Resource not found")
  end

  @doc """
  Set the response type of a route to application/json.
  """
  @spec json_resp(any(), any(), integer()) :: any()
  def json_resp(conn, body, status \\ 200) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(status, Jason.encode!(body))
  end
end
