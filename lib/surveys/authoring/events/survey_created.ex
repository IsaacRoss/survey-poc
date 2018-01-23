defmodule Surveys.Authoring.Events.SurveyCreated do
  @derive [Poison.Encoder]
  defstruct [
    :survey_uuid,
    :title,
    :status,
    :questions
  ]
end
