defmodule Api.Repo.Migrations.AddImagesFieldToProductsTable do
  use Ecto.Migration

  def up do
    alter table("products") do
      remove :image
      add(:images, {:array, :string})
    end
  end

  def down do
    alter table("products") do
      add :image, :string
      remove :images
    end
  end
end
