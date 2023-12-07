defmodule Api.Dbs.Catalog.Watcher do
  @moduledoc """
  This is a join schema for many-to-many relationship between
  users and products. It is used to track which products a user
  is watching.
  """

  use Ecto.Schema

  import Ecto.Changeset

  schema "watchers" do
    belongs_to(:user, Api.Dbs.Accounts.User)
    belongs_to(:product, Api.Dbs.Catalog.Product)

    timestamps()
  end

  def changeset(watcher, attrs \\ %{}) do
    watcher
    |> cast(attrs, [])
    |> cast_assoc(:user)
    |> cast_assoc(:product)
    |> validate_required([:user, :product])
    |> foreign_key_constraint(:product_id, message: "This product does not exist")
    |> unique_constraint(:user_id,
      name: :unique_user_product_watcher,
      message: "User already watching this product"
    )
  end
end
