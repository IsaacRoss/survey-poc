defmodule Surveys.Authoring.Commands.ChangeStatus do
  defstruct survey_uuid: "",
            status: ""

  use ExConstructor

  alias Surveys.Authoring.Commands.ChangeStatus

  def change_status(%ChangeStatus{} = survey, status) do
    %{survey | status: status}
  end
end
