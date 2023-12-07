defmodule Api.Dbs.Catalog.Product do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @required_fields ~w(name price stock_quantity condition)a
  @optional_fields ~w(description image)a

  schema "products" do
    field(:name, :string)
    field(:description, :string)
    field(:price, :decimal)
    field(:stock_quantity, :integer)
    field(:condition, :string)
    field(:image, :string)

    belongs_to(:category, Api.Dbs.Catalog.Category)
    belongs_to(:user, Api.Dbs.Accounts.User)

    many_to_many(:watchers, Api.Dbs.Accounts.User, join_through: "watchers")

    timestamps()
  end

  @doc """
  Returns the schema fields.
  """
  def fields(), do: @optional_fields ++ @required_fields

  @doc false
  @spec changeset(product :: __MODULE__.t(), params :: map()) :: Ecto.Changeset.t()
  def changeset(product, params) do
    product
    |> cast(params, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> validate_number(:price, greater_than: 0)
    |> validate_number(:stock_quantity, greater_than_or_equal_to: 0)
    |> validate_inclusion(:condition, ["new", "used"])
    |> unique_constraint([:name, :user_id, :category_id],
      name: :unique_product_name_category_per_user,
      message: "Duplicate product"
    )
  end
end
