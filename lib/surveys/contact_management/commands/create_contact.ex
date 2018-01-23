defmodule Surveys.ContactManagement.Commands.CreateContact do
  defstruct uuid: "",
            email: ""

  use ExConstructor
  use Vex.Struct

  alias Surveys.ContactManagement.Commands.CreateContact

  def assign_uuid(%CreateContact{} = created, uuid) do
    %CreateContact{created | uuid: uuid}
  end
end
