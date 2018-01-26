defmodule Surveys.Authoring.Aggregates.Survey do
  defstruct [
    :uuid,
    :title,
    :status,
    :questions
  ]

  alias Surveys.Authoring.Aggregates.Survey
  alias Surveys.Authoring.Commands.{CreateSurvey, ChangeStatus, ChangeTitle, UpdateSurvey}
  alias Surveys.Authoring.Events.{SurveyCreated, StatusChanged, TitleChanged}

  @doc """
  Create a new survey draft
  """
  def execute(%Survey{uuid: nil}, %CreateSurvey{} = create) do
    %SurveyCreated{
      survey_uuid: create.survey_uuid,
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
      survey_uuid: change.survey_uuid,
      status: change.status
    }
  end

  def execute(%Survey{} = survey, %UpdateSurvey{} = update) do
    Enum.reduce([&title_changed/2, &status_changed/2], [], fn change, events ->
      case change.(survey, update) do
        nil -> events
        event -> [event | events]
      end
    end)
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
      | uuid: created.survey_uuid,
        title: created.title,
        status: created.status,
        questions: created.questions
    }
  end

  def apply(%Survey{} = survey, %TitleChanged{} = changed) do
    %Survey{
      survey
      | title: changed.title
    }
  end

  ####### HELPERS
  defp title_changed(%Survey{}, %UpdateSurvey{title: ""}), do: nil
  defp title_changed(%Survey{title: title}, %UpdateSurvey{title: title}), do: nil

  defp title_changed(%Survey{uuid: survey_uuid}, %UpdateSurvey{title: title}) do
    %TitleChanged{
      survey_uuid: survey_uuid,
      title: title
    }
  end

  defp status_changed(%Survey{}, %UpdateSurvey{status: ""}), do: nil
  defp status_changed(%Survey{status: status}, %UpdateSurvey{status: status}), do: nil

  defp status_changed(%Survey{uuid: survey_uuid}, %UpdateSurvey{status: status}) do
    %StatusChanged{
      survey_uuid: survey_uuid,
      status: status
    }
  end
end
