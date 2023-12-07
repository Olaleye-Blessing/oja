defmodule Api.Repo.Migrations.AddWatchersTable do
  use Ecto.Migration

  def change do
    create table(:watchers) do
      add(:user_id, references(:users, on_delete: :delete_all), null: false)
      add(:product_id, references(:products, on_delete: :delete_all), null: false)

      timestamps()
    end

    create unique_index("watchers", [:user_id, :product_id], name: :unique_user_product_watcher)
  end
end
