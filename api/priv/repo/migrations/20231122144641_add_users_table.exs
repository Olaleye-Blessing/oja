defmodule API.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :username, :string, null: false
      add :email, :string, null: false
      add :password, :string, null: false

      timestamps()
    end

    create unique_index("users", :username)
    create unique_index("users", :email)
  end
end
