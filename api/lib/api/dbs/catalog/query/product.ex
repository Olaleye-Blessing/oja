defmodule Api.Dbs.Catalog.Query.Product do
  @moduledoc """
  Provides all query to the product table
  """

  import Ecto.Query

  alias Api.Dbs.Catalog.{Product, Watcher}

  def base_query() do
    from(p in Product)
  end

  def base(), do: from(p in Product)

  def filter(params \\ %{}) do
    base()
    |> filter_field(:name, get_field_value(params, :name))
    |> filter_field(:condition, get_field_value(params, :condition))
    |> filter_field(:category, get_field_value(params, :category))
    |> filter_field(:price, get_field_value(params, :price))
    |> set_watchers_count()
  end

  def set_watchers_count(query) do
    from(p in query,
      left_join: w in Watcher,
      on: p.id == w.product_id,
      group_by: p.id,
      select: %{product: p, watchers_count: count(w.id)}
    )
  end

  defp get_field_value(params, field) do
    Map.get(params, field, nil)
  end

  defp filter_field(query, _field, _value = nil) do
    query
  end

  defp filter_field(query, :name, name) do
    name =
      name
      # escape "%"
      |> String.replace("%", "\\%")
      # match any string that contains name
      |> (&"%#{&1}%").()
      # build query
      |> (&dynamic([p], ilike(p.name, ^&1))).()

    from(query, where: ^name)
  end

  defp filter_field(query, :condition, condition) do
    condition = dynamic([p], p.condition == ^condition)

    from(query, where: ^condition)
  end

  defp filter_field(query, :category, category) do
    from(p in query,
      join: c in assoc(p, :category),
      where: c.id == ^category
    )
  end

  defp filter_field(query, :price, price) do
    price =
      case price do
        %{from: nil, to: nil} -> dynamic([p], p.price >= 0)
        %{from: from, to: nil} -> dynamic([p], p.price >= ^from)
        %{from: nil, to: to} -> dynamic([p], p.price <= ^to)
        %{from: from, to: to} -> dynamic([p], p.price >= ^from and p.price <= ^to)
      end

    from(query, where: ^price)
  end
end
