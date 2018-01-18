defmodule Surveys.Authoring.Commands.CreateSurvey do
  defstruct survey_uuid: "",
            title: "",
            questions: %{}

  use ExConstructor
end

defmodule Surveys.Authoring.Events.SurveyCreated do
  @derive [Poison.Encoder]
  defstruct [
    :survey_uuid,
    :title,
    :questions
  ]
end

defmodule Surveys.Router do
  use Commanded.Commands.Router

  alias Surveys.Authoring.Aggregates.SurveyDraft
  alias Surveys.Authoring.Commands.CreateSurvey

  dispatch(
    [
      CreateSurvey
    ],
    to: SurveyDraft,
    identity: :survey_uuid
  )
end

defmodule Surveys.Authoring.Projectors.SurveyDraft do
  use Commanded.Projections.Ecto,
    name: "Authoring.Projectors.SurveyDraft",
    repo: Surveys.Repo,
    consistency: :strong

  alias Surveys.Authoring.Events.SurveyCreated
  alias Surveys.Authoring.Projections.SurveyDraft

  project %SurveyCreated{} = created do
    Ecto.Multi.insert(multi, :surveydraft, %SurveyDraft{
      uuid: created.survey_uuid,
      title: created.title,
      questions: created.questions
    })
  end
end
