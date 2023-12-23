defmodule Api.Repo.Migrations.RenamePurchasesTable do
  use Ecto.Migration

  def up do
    drop constraint(:purchases, "purchases_user_id_fkey")
    drop index(:purchases, [:user_id])

    rename table(:purchases), to: table(:orders)

    alter table(:orders) do
      # "Modifying" the columns rengenerates the constraints with the correct
      # new names. These were the same types and options the columns were
      # originally created with in previous migrations.
      modify :id, :bigint
      modify :user_id, references(:users, on_delete: :nothing), null: false
    end

    create index(:orders, [:user_id])

    # Rename the ID sequence. I don't think this affects Ecto, but it keeps
    # the naming and structure of the table more consistent.
    execute "ALTER SEQUENCE purchases_id_seq RENAME TO orders_id_seq;"
  end

  def down do
    drop constraint(:orders, "orders_user_id_fkey")
    drop index(:orders, [:user_id])

    rename table(:orders), to: table(:purchases)

    alter table(:purchases) do
      modify :id, :bigint
      modify :user_id, references(:users, on_delete: :nothing), null: false
    end

    create index(:purchases, [:user_id])

    execute "ALTER SEQUENCE orders_id_seq RENAME TO purchases_id_seq;"
  end
end
