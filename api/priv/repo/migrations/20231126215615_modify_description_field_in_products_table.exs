defmodule Api.Repo.Migrations.ModifyDescriptionFieldInProductsTable do
  use Ecto.Migration

  def up do
    alter table("products") do
      modify :description, :text
    end
  end

  def down do
    alter table("products") do
      modify :description, :string
    end
  end
end
