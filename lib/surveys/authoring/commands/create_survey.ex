defmodule Surveys.Authoring.Commands.CreateSurvey do
  defstruct uuid: "",
            title: "",
            status: "DRAFT",
            questions: []

  use ExConstructor
  use Vex.Struct

  alias Surveys.Authoring.Commands.CreateSurvey

  @doc """
  assigns unique identifier to created survey
  """
  def assign_uuid(%CreateSurvey{} = created, uuid) do
    %CreateSurvey{created | uuid: uuid}
  end
end
