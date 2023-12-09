defmodule Api.CurrencyConverter.Converter do
  @moduledoc """
  Handle currency conversion using an external API.
  """

  use GenServer

  alias Api.CurrencyConverter.HttpClient

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    send(self(), :fetch_currencies)

    {:ok, %{currencies: nil, conversions: %{}}}
  end

  def handle_call(:currencies, _from, state) do
    {:reply, Map.get(state, :currencies, nil), state}
  end

  def handle_call({:convert, to}, _from, state) do
    case Map.get(state.conversions, to, nil) do
      nil ->
        value = HttpClient.convert_currency(to)
        {:reply, value, put_in(state.conversions[to], value)}

      val ->
        {:reply, val, state}
    end
  end

  def handle_info(:fetch_currencies, state) do
    {:noreply, Map.put(state, :currencies, HttpClient.get_supported_currencies())}
  end

  def currencies() do
    GenServer.call(__MODULE__, :currencies)
  end

  def convert(to) do
    GenServer.call(__MODULE__, {:convert, to})
  end
end
