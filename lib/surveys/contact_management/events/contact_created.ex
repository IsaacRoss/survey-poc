defmodule Surveys.ContactManagement.Events.ContactCreated do
  @derive [Poison.Encoder]
  defstruct [
    :uuid,
    :email
  ]
end
