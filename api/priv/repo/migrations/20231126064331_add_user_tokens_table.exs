defmodule Api.Repo.Migrations.AddUserTokensTable do
  use Ecto.Migration

  def change do
    create table(:users_tokens) do
      add :token, :binary, null: false
      add :context, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :user_id])
  end
end
