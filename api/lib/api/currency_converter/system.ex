defmodule Api.CurrencyConverter.System do
  @moduledoc false
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, nil)
  end

  def init(_) do
    Supervisor.init(
      [Api.CurrencyConverter.Converter],
      strategy: :one_for_one
    )
  end
end
