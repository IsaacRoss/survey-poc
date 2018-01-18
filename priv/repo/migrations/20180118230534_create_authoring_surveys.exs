defmodule Surveys.Repo.Migrations.CreateAuthoringSurveys do
  use Ecto.Migration

  def change do
    create table(:authoring_surveys, primary_key: false) do
      add(:uuid, :uuid, primary_key: true)
      add(:title, :string)
      add(:questions, {:array, :map})

      timestamps()
    end
  end
end
