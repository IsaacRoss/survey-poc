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
