defmodule Api.Dbs.Cart.Product do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @required_fields ~w(quantity price product_id)a

  def fields(), do: @required_fields

  embedded_schema do
    field(:quantity, :integer)
    field(:price, :decimal)

    belongs_to(:product, Api.Dbs.Catalog.Product)
  end

  @doc false
  @spec changeset(track_embed :: __MODULE__.t(), params :: map()) :: Ecto.Changeset.t()
  def changeset(track_embed, params) do
    track_embed
    |> cast(params, fields())
    |> validate_required(@required_fields)
  end
end
