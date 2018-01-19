defmodule Surveys.Authoring.Events.SurveyCreated do
  @derive [Poison.Encoder]
  defstruct [
    :uuid,
    :title,
    :questions
  ]
end
