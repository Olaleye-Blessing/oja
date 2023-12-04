defmodule Api.Dbs.Cart.Purchase do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @required_fields ~w(status user_id total_price)a

  schema "purchases" do
    embeds_many(:products, Api.Dbs.Cart.Product, on_replace: :delete)
    embeds_one(:shipping_address, Api.Dbs.Cart.ShippingAddress, on_replace: :update)

    field(:status, :string)
    field(:total_price, :decimal)
    belongs_to(:user, Api.Dbs.Accounts.User)

    timestamps()
  end

  @doc false
  @spec changeset(info :: __MODULE__.t(), params :: map()) :: Ecto.Changeset.t()
  def changeset(info, params) do
    info
    |> cast(params, @required_fields)
    |> cast_embed(:shipping_address)
    |> cast_embed(:products)
    |> validate_required(@required_fields)
    |> validate_inclusion(:status, ["pending", "cancelled", "shipped", "delivered"])
    |> foreign_key_constraint(:user_id)
  end
end
