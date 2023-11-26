defmodule Api.Dbs.Items do
  # Api.Dbs.Product
  @moduledoc false

  alias Api.Repo
  alias Api.Dbs.Items.Products

  def create_product(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:products)
    |> Products.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get all products
  """
  def list_products() do
    Products
    |> Repo.all()
  end
end
