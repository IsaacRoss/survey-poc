defmodule Surveys.ContactManagement.Events.ContactDeleted do
  @derive [Poison.Encoder]
  defstruct [
    :uuid
  ]
end
