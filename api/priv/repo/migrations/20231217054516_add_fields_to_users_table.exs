defmodule Api.Repo.Migrations.AddFieldsToUsersTable do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :avatar_url, :string, default: ""
      add :bio, :string, default: ""
      add :website, :string, default: ""
      add :phone_number, :string, default: ""
      add :city, :string, default: ""
      add :state, :string, default: ""
      add :country, :string, default: ""
      add :tiktok, :string, default: ""
      add :twitter, :string, default: ""
      add :instagram, :string, default: ""
    end
  end
end
