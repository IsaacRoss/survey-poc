defmodule Surveys.Authoring.Events.TitleChanged do
  @derive [Poison.Encoder]
  defstruct [
    :uuid,
    :title
  ]
end
