defmodule Surveys.Authoring.Events.StatusChanged do
  @derive [Poison.Encoder]
  defstruct [
    :uuid,
    :status
  ]
end
