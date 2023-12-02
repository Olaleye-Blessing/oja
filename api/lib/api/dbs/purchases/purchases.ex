defmodule Api.Dbs.Purchases.Purchases do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  schema "purchases" do
    embeds_many(:products, Api.Dbs.Purchases.Product, on_replace: :delete)
    embeds_one(:shipping_address, Api.Dbs.Purchases.ShippingAddress, on_replace: :update)

    field(:status, :string)
    field(:total_price, :decimal)
    belongs_to(:user, Api.Dbs.Accounts.User)

    timestamps()
  end

  def changeset(info, params) do
    info
    |> cast(params, [:status, :user_id, :total_price])
    |> cast_embed(:shipping_address)
    |> cast_embed(:products)
    |> validate_required([:status, :user_id, :total_price])
    |> validate_inclusion(:status, ["pending", "cancelled", "shipped", "delivered"])
    |> foreign_key_constraint(:user_id)
  end
end
