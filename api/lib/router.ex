defmodule API.Router do
  use Plug.Router

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

  get "/" do
    conn |> json_resp(%{message: "Home page"})
  end

  match _ do
    send_resp(conn, 404, "Resource not found")
  end

  @spec json_resp(any(), any(), integer()) :: any()
  def json_resp(conn, body, status \\ 200) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(status, Jason.encode!(body))
  end
end
