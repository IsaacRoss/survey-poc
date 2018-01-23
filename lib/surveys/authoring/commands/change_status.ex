defmodule Surveys.Authoring.Commands.ChangeStatus do
  defstruct survey_uuid: "",
            status: ""

  use ExConstructor
  use Vex.Struct

  validates(:status, inclusion: ["PUBLISHED", "DRAFT"])

  alias Surveys.Authoring.Commands.ChangeStatus

  def change_status(%ChangeStatus{} = survey, status) do
    %{survey | status: status}
  end
end
