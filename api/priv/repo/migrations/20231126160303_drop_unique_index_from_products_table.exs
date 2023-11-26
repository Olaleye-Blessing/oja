defmodule Api.Repo.Migrations.DropUniqueIndexFromProductsTable do
  use Ecto.Migration

  def up do
    drop index("products", [:name, :user_id], name: :unique_product_name_per_user)
  end

  def down do
    create unique_index("products", [:name, :user_id], name: :unique_product_name_per_user)
  end
end
