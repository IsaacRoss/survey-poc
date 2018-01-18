defmodule Surveys.Authoring.Aggregates.SurveyDraft do
  defstruct [
    :uuid,
    :title,
    :questions
  ]

  alias Surveys.Authoring.Aggregates.SurveyDraft
  alias Surveys.Authoring.Commands.CreateSurvey
  alias Surveys.Authoring.Events.SurveyCreated

  @doc """
  Create a new survey draft
  """
  def execute(%SurveyDraft{uuid: nil}, %CreateSurvey{} = create) do
    %SurveyCreated{
      title: create.title,
      questions: create.questions
    }
  end

  # Mutate existing draft state
  def apply(%SurveyDraft{} = survey, %SurveyCreated{} = created) do
    %SurveyDraft{survey | uuid: created.uuid, title: created.title, questions: created.questions}
  end
end
