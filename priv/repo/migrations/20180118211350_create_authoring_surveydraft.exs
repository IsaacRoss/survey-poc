defmodule Surveys.Repo.Migrations.CreateAuthoringSurveydraft do
  use Ecto.Migration

  def change do
    create table("authoring_survey_drafts") do
      add :uuid, :uuid, primary_key: true
      add :title, :string
      add :questions, :jsonb

      timestamps()
    end
  end
end
