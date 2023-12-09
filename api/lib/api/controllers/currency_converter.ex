defmodule Api.Controllers.CurrencyConverter do
  @moduledoc false

  alias Api.Router

  alias Api.CurrencyConverter.Converter

  def get_curriencies(conn) do
    Router.json_resp(:ok, conn, Converter.currencies(), 200)
  end

  def convert(%{query_params: %{"to" => to}} = conn) do
    Router.json_resp(:ok, conn, %{value: Converter.convert(to)}, 200)
  end

  def convert(conn) do
    Router.json_resp(:error, conn, "Provide the currency to convert to as query params", 400)
  end
end
