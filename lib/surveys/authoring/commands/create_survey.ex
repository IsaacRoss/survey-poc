defmodule Surveys.Authoring.Commands.CreateSurvey do
  defstruct [
    survey_uuid: "",
    title: "",
    questions: %{}
  ]
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

  dispatch [
    CreateSurvey
  ] to: SurveyDraft, identity: :uuid
end
