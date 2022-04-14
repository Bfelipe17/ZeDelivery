defmodule ZeDelivery.Repo.Migrations.CreatePartners do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS postgis"

    create table(:partners) do
      add :tradingName, :string
      add :ownerName, :string
      add :document, :string
      add :coverageArea, :geometry
      add :address, :geometry

      timestamps()
    end

    create unique_index(:partners, [:document])
  end

  def down do
    execute "DROP EXTENSION IF EXISTS postgis"
  end
end
