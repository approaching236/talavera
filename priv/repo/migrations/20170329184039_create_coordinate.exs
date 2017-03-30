defmodule Talavera.Repo.Migrations.CreateCoordinate do
  use Ecto.Migration

  def change do
    create table(:coordinates) do
      add :q, :integer
      add :r, :integer
      add :s, :integer

      timestamps()
    end

  end
end
