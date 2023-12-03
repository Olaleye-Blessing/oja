defmodule Api.Dbs.Cart.Product do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @required_fields ~w(quantity price product_id)a

  def fields(), do: @required_fields

  embedded_schema do
    field(:quantity, :integer)
    field(:price, :decimal)

    belongs_to(:product, Api.Dbs.Catalog.Product)
  end

  def changeset(track_embed, params) do
    track_embed
    |> cast(params, fields())
    |> validate_required(@required_fields)
  end
end
