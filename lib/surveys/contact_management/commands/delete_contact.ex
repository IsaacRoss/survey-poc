defmodule Surveys.ContactManagement.Commands.DeleteContact do
    defstruct uuid: "",
      email: ""

    use ExConstructor
    use Vex.Struct

    alias Surveys.ContactManagement.Commands.DeleteContact

    def assign_uuid(%DeleteContact{} = deleted, uuid) do
      %DeleteContact{deleted | uuid: uuid}
    end

end
