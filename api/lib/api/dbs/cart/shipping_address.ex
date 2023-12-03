defmodule Api.Dbs.Cart.ShippingAddress do
  use Ecto.Schema

  import Ecto.Changeset

  @required_fields ~w(country state city address full_name)a
  @optional_fields ~w(zip_code)a

  def fields(), do: @required_fields ++ @optional_fields

  embedded_schema do
    field(:country, :string)
    field(:state, :string)
    field(:city, :string)
    field(:zip_code, :string)
    field(:address, :string)
    field(:full_name, :string)
  end

  def changeset(track_embed, params) do
    track_embed
    |> cast(params, fields())
    |> validate_required(@required_fields)
  end
end
