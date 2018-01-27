defmodule Surveys.Authoring.Commands.UpdateSurvey do
  defstruct [:survey_uuid, :title, :questions, :status]

  alias Surveys.Authoring.Commands.UpdateSurvey
  alias Surveys.Authoring.Projections.Survey

  use ExConstructor
  use Vex.Struct

  validates(:survey_uuid, uuid: true)

  validates(:title, presence: [message: "can't be empty"])

  validates(:status, inclusion: ["PUBLISHED", "DRAFT"])

  validates(
    :questions,
    length: [min: 1],
    by: [function: &UpdateSurvey.all_maps/1, message: "must be objects"]
  )

  def assign_survey(%UpdateSurvey{} = update_survey, %Survey{uuid: survey_uuid}) do
    %UpdateSurvey{update_survey | survey_uuid: survey_uuid}
  end

  def all_maps(questions) do
    Enum.all?(questions, &map_valid/1)
  end

  def map_valid(map) do
    len = Map.keys(map) |> Enum.count()
    is_map(map) && len > 0
  end
end
