defmodule Surveys.Authoring.Commands.CreateSurvey do
  defstruct uuid: "",
            title: "",
            questions: []

  use ExConstructor
  alias Surveys.Authoring.Commands.CreateSurvey

  def assign_uuid(%CreateSurvey{} = created, uuid) do
    %CreateSurvey{created | uuid: uuid}
  end
end
