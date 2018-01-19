defmodule Surveys.Authoring.Projectors.Survey do
  use Commanded.Projections.Ecto,
    name: "Authoring.Projectors.Survey",
    repo: Surveys.Repo,
    consistency: :strong

  alias Surveys.Authoring.Events.{SurveyCreated, StatusChanged}
  alias Surveys.Authoring.Projections.Survey

  project %SurveyCreated{} = created do
    Ecto.Multi.insert(multi, :survey, %Survey{
      uuid: created.uuid,
      title: created.title,
      status: created.status,
      questions: created.questions
    })
  end

  project %StatusChanged{} = changed do
    Ecto.Multi.insert(multi, :survey, %Survey{
      uuid: changed.uuid,
      status: changed.status
    })
  end
end
