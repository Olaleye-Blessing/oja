defmodule Api.CurrencyConverter.HttpClient do
  @moduledoc """
  Module for making HTTP requests to the currency conversion API.
  """

  @currency_converter_base_url "https://currency-converter18.p.rapidapi.com/api/v1"
  @x_rapid_api_key "014541152bmshd96bfaf01f1e54ep1f8c7fjsn6ac2e70d93c1"

  @headers [
    {"X-RapidAPI-Key", @x_rapid_api_key},
    {"X-RapidAPI-Host", "currency-converter18.p.rapidapi.com"}
  ]

  @base_request Req.new(base_url: @currency_converter_base_url, headers: @headers)

  def base(), do: @base_request

  def get_supported_currencies() do
    {_request, response} = fetch_supported_currencies()

    case response do
      %{status: 200, body: body} -> body
      %{status: _status, body: _error} -> "This service is not available. Please, try again later"
    end
  end

  def convert_currency(to) do
    {_request, response} = convert(to)

    case response do
      %{status: 200, body: body} -> parse_converted_currency(body)
      %{status: _status, body: _error} -> :service_unavilable
    end
  end

  defp fetch_supported_currencies() do
    base()
    |> Req.update(url: "/supportedCurrencies")
    |> Req.Request.run_request()
  end

  defp convert(to) do
    base()
    |> Req.update(url: "/convert?from=USD&to=#{to}&amount=1")
    |> Req.Request.run_request()
  end

  defp parse_converted_currency(%{"validationMessage" => [_msg | _]}) do
    :not_supported
  end

  defp parse_converted_currency(%{"result" => %{"convertedAmount" => value}}) do
    value
  end

  defp parse_converted_currency(_body) do
    :unknown
  end
end
