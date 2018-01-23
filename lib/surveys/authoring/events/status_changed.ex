defmodule Surveys.Authoring.Events.StatusChanged do
  @derive [Poison.Encoder]
  defstruct [
    :survey_uuid,
    :status
  ]
end
