defmodule Surveys.ContactManagement.Commands.CreateContact do
  defstruct contact_uuid: "",
            email: ""

  use ExConstructor
  use Vex.Struct

  alias Surveys.ContactManagement.Commands.CreateContact

  def assign_uuid(%CreateContact{} = created, uuid) do
    %CreateContact{created | contact_uuid: uuid}
  end
end
