defmodule Api.Repo.Migrations.AddProductsTable do
  use Ecto.Migration

  def change do
    create table("products") do
      add :name, :string, null: false
      add :price, :decimal, null: false
      add :stock_quantity, :integer, null: false
      add :category, :string, null: false
      add :condition, :string, null: false
      add :description, :string
      add :image, :string

      add :user_id, references("users", on_delete: :delete_all)

      timestamps()
    end

    create unique_index("products", [:name, :user_id], name: :unique_product_name_per_user)
    create constraint("products", :stock_quantity_must_be_postive, check: "stock_quantity >= 0")
    create constraint("products", :price_must_be_greater_than_zero, check: "price > 0")
    create constraint("products", :condition_must_be_valid, check: "condition IN ('new', 'used')")
  end
end
