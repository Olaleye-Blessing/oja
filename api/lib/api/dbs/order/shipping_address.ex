defmodule Api.Dbs.Order.ShippingAddress do
  use Ecto.Schema

  import Ecto.Changeset

  @type t :: %__MODULE__{}

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

  @doc false
  @spec changeset(track_embed :: __MODULE__.t(), params :: map()) :: Ecto.Changeset.t()
  def changeset(track_embed, params) do
    track_embed
    |> cast(params, fields())
    |> validate_required(@required_fields)
  end
end
