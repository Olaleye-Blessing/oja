defmodule Api.Dbs.Items do
  # Api.Dbs.Product
  @moduledoc false

  alias Api.Repo
  alias Api.Dbs.Items.{Products, Category}

  def create_product(user, category, attrs \\ %{}) do
    %Products{}
    |> Products.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Ecto.Changeset.put_assoc(:category, category)
    |> Repo.insert()
  end

  @doc """
  Get all products
  """
  def list_products() do
    Products
    |> Repo.all()
    |> Repo.preload([:category])
  end

  @doc """
  Get a product by id
  """
  def get_product(id, preloaded_fields \\ [:category, :user]) do
    Products |> Repo.get(id) |> Repo.preload(preloaded_fields)
  end

  @doc """
  Create a category
  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get all categories
  """
  def list_categories() do
    Category
    |> Repo.all()
  end

  @doc """
  Check if a category exits
  """
  def category_exists?(category_id) do
    Category
    |> Repo.exists?(id: category_id)
  end

  @doc """
  Get a category by id
  """
  def get_category(category_id) do
    Category
    |> Repo.get(category_id)
  end
end
