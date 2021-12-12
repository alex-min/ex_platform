defmodule ExPlatform.Repo.Migrations.UserAdmin do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :is_admin, :boolean, default: false, null: false
    end
  end
end
