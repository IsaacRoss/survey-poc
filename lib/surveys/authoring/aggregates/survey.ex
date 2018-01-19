defmodule Surveys.Authoring.Aggregates.Survey do
  defstruct [
    :uuid,
    :title,
    :status,
    :questions
  ]

  alias Surveys.Authoring.Aggregates.Survey
  alias Surveys.Authoring.Commands.{CreateSurvey, ChangeStatus}
  alias Surveys.Authoring.Events.{SurveyCreated, StatusChanged}

  @doc """
  Create a new survey draft
  """
  def execute(%Survey{uuid: nil}, %CreateSurvey{} = create) do
    %SurveyCreated{
      uuid: create.uuid,
      title: create.title,
      status: create.status,
      questions: create.questions
    }
  end

  @doc """
  Change the status of a survey
  """
  def execute(%Survey{}, %ChangeStatus{} = change) do
    %StatusChanged{
      uuid: change.uuid,
      status: change.status
    }
  end

  # Mutate existing draft state
  def apply(%Survey{} = survey, %StatusChanged{} = changed) do
    %Survey{
      survey
      | status: changed.status
    }
  end

  def apply(%Survey{} = survey, %SurveyCreated{} = created) do
    %Survey{
      survey
      | uuid: created.uuid,
        title: created.title,
        status: created.status,
        questions: created.questions
    }
  end
end
