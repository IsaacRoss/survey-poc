defmodule Surveys.Authoring.Aggregates.Survey do
  defstruct [
    :uuid,
    :title,
    :questions
  ]

  alias Surveys.Authoring.Aggregates.Survey
  alias Surveys.Authoring.Commands.CreateSurvey
  alias Surveys.Authoring.Events.SurveyCreated

  @doc """
  Create a new survey draft
  """
  def execute(%Survey{uuid: nil}, %CreateSurvey{} = create) do
    %SurveyCreated{
      uuid: create.uuid,
      title: create.title,
      questions: create.questions
    }
  end

  # Mutate existing draft state
  def apply(%Survey{} = survey, %SurveyCreated{} = created) do
    %Survey{
      survey
      | uuid: created.uuid,
        title: created.title,
        questions: created.questions
    }
  end
end
