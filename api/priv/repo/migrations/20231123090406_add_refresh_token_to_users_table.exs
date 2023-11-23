defmodule Api.Repo.Migrations.AddRefreshTokenToUsersTable do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :refresh_token, :string
    end
  end
end
