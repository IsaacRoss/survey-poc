defmodule Surveys.Authoring.Projections.SurveyDraft do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "authoring_surveys_draft" do
    field :title, :string
    field :questions, :map
  end
end
