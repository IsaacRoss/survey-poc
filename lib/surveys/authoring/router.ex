defmodule Surveys.Router do
  use Commanded.Commands.Router

  alias Surveys.Authoring.Aggregates.Survey
  alias Surveys.Authoring.Commands.CreateSurvey

  dispatch(
    [
      CreateSurvey
    ],
    to: Survey,
    identity: :uuid
  )
end
