defmodule Surveys.Authoring.Commands.CreateSurvey do
  defstruct survey_uuid: "",
            title: "",
            status: "DRAFT",
            questions: []

  use ExConstructor
  use Vex.Struct

  alias Surveys.Authoring.Commands.CreateSurvey

  validates(:title, presence: [message: "Can not be empty"])
  validates(:questions, length: [min: 1])

  @doc """
  assigns unique identifier to created survey
  """
  def assign_uuid(%CreateSurvey{} = created, uuid) do
    %CreateSurvey{created | survey_uuid: uuid}
  end
end
