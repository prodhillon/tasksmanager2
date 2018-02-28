defmodule Tasksmanager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :manager, :string
      add :select_manager_id, references(:users)

      timestamps()
    end

  end
end
