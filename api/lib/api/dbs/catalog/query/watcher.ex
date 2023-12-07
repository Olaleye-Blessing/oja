defmodule Api.Dbs.Catalog.Query.Watcher do
  @moduledoc """
  Provides all query to the watchers table
  """
  import Ecto.Query

  alias Api.Dbs.Catalog.{Watcher}

  @doc """
  Returns the base query to get a watched product
  """
  @spec base(number(), number()) :: Ecto.Query.t()
  def base(user_id, product_id) do
    from(w in Watcher,
      where: w.user_id == ^user_id and w.product_id == ^product_id
    )
  end
end
