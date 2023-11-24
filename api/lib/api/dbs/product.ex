defmodule Api.Dbs.Product do
  @moduledoc false

  alias Api.Repo
  alias Api.Dbs.Schemas.Product, as: ProductSchema

  def create(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:products)
    |> ProductSchema.changeset(attrs)
    |> Repo.insert()
  end
end
