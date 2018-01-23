defmodule Surveys.ContactManagement.Commands.DeleteContact do
  defstruct contact_uuid: ""

  use ExConstructor
  use Vex.Struct

  alias Surveys.ContactManagement.Commands.DeleteContact

  def assign_uuid(%DeleteContact{} = deleted, uuid) do
    %DeleteContact{deleted | contact_uuid: uuid}
  end
end
