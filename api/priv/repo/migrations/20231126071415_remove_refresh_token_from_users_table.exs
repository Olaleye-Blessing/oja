defmodule Api.Repo.Migrations.RemoveRefreshTokenFromUsersTable do
  use Ecto.Migration

  def up do
    alter table("users") do
      remove :refresh_token
    end
  end

  def down do
    alter table("users") do
      add :refresh_token, :string
    end
  end
end
