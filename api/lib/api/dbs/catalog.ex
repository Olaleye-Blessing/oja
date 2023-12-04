defmodule Api.Dbs.Catalog do
  # Api.Dbs.Product
  @moduledoc false

  alias Api.Repo
  alias Api.Dbs.Catalog.{Product, Category}

  @doc """
  Create a product

  ## Examples

      iex> Api.Dbs.Catalog.create_product(%User{}, %Category{}, %{name: "Product 1", price: 100})
      {:ok, %Product{}}

      iex> Api.Dbs.Catalog.create_product(%User{}, %Category{}, %{invalid: "Product 1", price: 100})
      {:error, %Ecto.Changeset{}}
  """
  def create_product(user, category, attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Ecto.Changeset.put_assoc(:category, category)
    |> Repo.insert()
  end

  @doc """
  Get all products

  ## Examples

      iex> Api.Dbs.Catalog.list_products()
      [%Product{}, %Product{}]
  """
  def list_products() do
    Product
    |> Repo.all()
    |> Repo.preload([:category])
  end

  @doc """
  Get a product by id

  ## Examples

      iex> Api.Dbs.Catalog.get_product(1)
      %Product{}

      iex> Api.Dbs.Catalog.get_product(1, [:category])
      %Product{
        category: %Category{}
      }

      iex> Api.Dbs.Catalog.get_product(invalid_id)
      nil
  """
  def get_product(id, preloaded_fields \\ [:category, :user]) do
    Product |> Repo.get(id) |> Repo.preload(preloaded_fields)
  end

  @doc """
  Create a category

  ## Examples

      iex> Api.Dbs.Catalog.create_category(%{name: "Category 1"})
      {:ok, %Category{}}

      iex> Api.Dbs.Catalog.create_category(%{invalid: "Category 1"})
      {:error, %Ecto.Changeset{}}
  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get all categories

  ## Examples

      iex> Api.Dbs.Catalog.list_categories()
      [%Category{}, %Category{}]
  """
  def list_categories() do
    Category
    |> Repo.all()
  end

  @doc """
  Check if a category exits

  ## Examples

      iex> Api.Dbs.Catalog.category_exists?(1)
      true

      iex> Api.Dbs.Catalog.category_exists?(invalid_id)
      false
  """
  def category_exists?(category_id) do
    Category
    |> Repo.exists?(id: category_id)
  end

  @doc """
  Get a category by id

  ## Examples

      iex> Api.Dbs.Catalog.get_category(1)
      %Category{}

      iex> Api.Dbs.Catalog.get_category(invalid_id)
      nil
  """
  def get_category(category_id) do
    Category
    |> Repo.get(category_id)
  end
end
