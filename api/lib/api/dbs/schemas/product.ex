defmodule Api.Dbs.Schemas.Product do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @required_fields ~w(name price stock_quantity category condition)a
  @optional_fields ~w(description image)a

  schema "products" do
    field(:name, :string)
    field(:description, :string)
    field(:price, :decimal)
    field(:stock_quantity, :integer)
    field(:category, :string)
    field(:condition, :string)
    field(:image, :string)

    belongs_to(:user, Api.Dbs.Schema.User)

    timestamps()
  end

  def fields(), do: @optional_fields ++ @required_fields

  def changeset(product, params) do
    product
    |> cast(params, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> validate_number(:price, greater_than: 0)
    |> validate_number(:stock_quantity, greater_than_or_equal_to: 0)
    |> validate_inclusion(:condition, ["new", "used"])
    |> unique_constraint([:name, :user_id],
      name: :unique_product_name_per_user,
      message: "Duplicate product"
    )
  end
end
