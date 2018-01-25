defmodule Surveys.Authoring.Commands.CreateSurvey do
  defstruct survey_uuid: "",
            title: "",
            status: "DRAFT",
            questions: []

  use ExConstructor
  use Vex.Struct

  alias Surveys.Authoring.Commands.CreateSurvey

  validates(:survey_uuid, uuid: true)
  validates(:title, presence: [message: "Can not be empty"])

  validates(
    :questions,
    length: [min: 1],
    by: [function: &CreateSurvey.is_correct_shape?/1, message: "must be maps"]
  )

  @doc """
  assigns unique identifier to created survey
  """
  def assign_uuid(%CreateSurvey{} = created, uuid) do
    %CreateSurvey{created | survey_uuid: uuid}
  end

  def is_correct_shape?(list) do
    list |> Enum.all?(&is_map/1)
  end
end
