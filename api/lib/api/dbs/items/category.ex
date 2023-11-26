defmodule Api.Dbs.Items.Category do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  schema "categories" do
    field(:name, :string)
    has_many(:products, Api.Dbs.Items.Products)

    timestamps()
  end

  def changeset(category, params) do
    category
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
