defmodule Surveys.Authoring.Commands.CreateSurvey do
  defstruct uuid: "",
            title: "",
            questions: []

  use ExConstructor
end

defmodule Surveys.Authoring.Events.SurveyCreated do
  @derive [Poison.Encoder]
  defstruct [
    :uuid,
    :title,
    :questions
  ]
end

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

defmodule Surveys.Authoring.Projectors.Survey do
  use Commanded.Projections.Ecto,
    name: "Authoring.Projectors.Survey",
    repo: Surveys.Repo,
    consistency: :strong

  alias Surveys.Authoring.Events.SurveyCreated
  alias Surveys.Authoring.Projections.Survey

  project %SurveyCreated{} = created do
    Ecto.Multi.insert(multi, :survey, %Survey{
      uuid: created.uuid,
      title: created.title,
      questions: created.questions
    })
  end
end
