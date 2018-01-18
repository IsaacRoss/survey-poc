defmodule Surveys.Repo.Migrations.CreateAuthoringOutcomes do
  use Ecto.Migration

  def change do
    create table(:authoring_outcomes) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
