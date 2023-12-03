defmodule Api.Dbs.Catalog.Category do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  @type t :: %__MODULE__{}

  schema "categories" do
    field(:name, :string)
    has_many(:products, Api.Dbs.Catalog.Product)

    timestamps()
  end

  @spec changeset(category :: __MODULE__.t(), params :: map()) :: Ecto.Changeset.t()
  def changeset(category, params) do
    category
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
