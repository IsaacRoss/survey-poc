defmodule Surveys.Authoring.Events.TitleChanged do
  @derive [Poison.Encoder]
  defstruct [
    :survey_uuid,
    :title
  ]
end
