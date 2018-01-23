defmodule Surveys.ContactManagement.Events.ContactDeleted do
  @derive [Poison.Encoder]
  defstruct [
    :contact_uuid
  ]
end
