defmodule Surveys.Authoring.Projections.SurveyDraft do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "authoring_survey_drafts" do
    field(:title, :string)
    field(:questions, {:array, :map})

    timestamps()
  end
end
