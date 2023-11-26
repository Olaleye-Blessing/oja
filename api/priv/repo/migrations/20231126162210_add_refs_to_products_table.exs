defmodule Api.Repo.Migrations.AddRefsToProductsTable do
  use Ecto.Migration

  def change do
    alter table ("products") do
      remove :category
      remove :user_id, references("users", on_delete: :delete_all)

      add :category_id, references("categories", on_delete: :nilify_all), null: false
      add :user_id, references("users", on_delete: :delete_all), null: false
    end

    create index("products", [:name])
    create unique_index("products", [:name, :user_id, :category_id], name: :unique_product_name_category_per_user)
  end
end
