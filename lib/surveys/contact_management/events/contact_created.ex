defmodule Surveys.ContactManagement.Events.ContactCreated do
  @derive [Poison.Encoder]
  defstruct [
    :contact_uuid,
    :email
  ]
end
