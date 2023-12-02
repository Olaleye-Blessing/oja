defmodule Api.Dbs.Purchases.Product do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @required_fields ~w(quantity price product_id)a

  def fields(), do: @required_fields

  embedded_schema do
    field(:quantity, :integer)
    field(:price, :decimal)

    belongs_to(:product, Api.Dbs.Items.Products)
  end

  def changeset(track_embed, params) do
    track_embed
    |> cast(params, fields())
    |> validate_required(@required_fields)

    # |> cast_assoc(:product)
  end
end
