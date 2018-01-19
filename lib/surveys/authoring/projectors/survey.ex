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

  project %StatusChanged{uuid: uuid, status: status} = changed do
    update_survey(multi, uuid, status: status)
  end

  defp update_survey(multi, uuid, changes) do
    Ecto.Multi.update_all(multi, :survey, survey_query(uuid), set: changes)
  end

  defp survey_query(uuid) do
    from(s in Survey, where: s.uuid == ^uuid)
  end
end
