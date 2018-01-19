defmodule Surveys.Repo.Migrations.AddStatusToSurvey do
  use Ecto.Migration

  def change do
    alter table(:authoring_surveys) do
      add(:status, :string)
    end
  end
end
