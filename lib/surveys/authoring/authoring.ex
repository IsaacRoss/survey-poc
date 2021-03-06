defmodule Surveys.Authoring do
  @moduledoc """
  The Authoring context.
  """
  alias Surveys.Authoring.Commands.{CreateSurvey, ChangeStatus, ChangeTitle, UpdateSurvey}
  alias Surveys.Authoring.Projections.Survey
  alias Surveys.{Repo, Router}

  def create_survey(attrs \\ {}) do
    uuid = UUID.uuid4()

    created_survey =
      attrs
      |> CreateSurvey.new()
      |> CreateSurvey.assign_uuid(uuid)

    with :ok <- Router.dispatch(created_survey, consistency: :strong) do
      get(Survey, uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Updates the title and / or questions and / or status of a survey
  """
  def update_survey(%Survey{uuid: survey_uuid} = survey, attrs \\ %{}) do
    update_survey =
      attrs
      |> UpdateSurvey.new()
      |> UpdateSurvey.assign_survey(survey)

    with :ok <- Router.dispatch(update_survey, consistency: :strong) do
      get(Survey, update_survey.survey_uuid)
    else
      reply -> reply
    end
  end

  def change_status(survey_attrs, status) do
    changed_survey =
      survey_attrs
      |> ChangeStatus.new()
      |> ChangeStatus.change_status(status)

    with :ok <- Router.dispatch(changed_survey, consistency: :strong) do
      get(Survey, changed_survey.survey_uuid)
    else
      reply -> reply
    end
  end

  def change_title(survey_attrs, title) do
    changed_survey =
      survey_attrs
      |> ChangeTitle.new()
      |> ChangeTitle.change_title(title)

    with :ok <- Router.dispatch(changed_survey, consistency: :strong) do
      get(Survey, changed_survey.uuid)
    else
      reply -> reply
    end
  end

  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
