defmodule Api.Repo.Migrations.AddPurchasesTable do
  use Ecto.Migration

  def change do
    create table(:purchases) do
      add :status, :string
      add :total_price, :decimal, default: 0.0
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :shipping_address, :jsonb, null: false
      add :products, {:array, :jsonb}, default: []

      timestamps()
    end

    create index(:purchases, [:user_id])
    create constraint(:purchases, :status_must_be_valid, check: "status IN ('pending', 'cancelled', 'shipped', 'delivered')")
  end
end
