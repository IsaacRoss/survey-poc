defmodule Surveys.Authoring.Commands.ChangeTitle do
  defstruct uuid: "",
            title: ""

  use ExConstructor

  alias Surveys.Authoring.Commands.ChangeTitle

  def change_title(%ChangeTitle{} = survey, title) do
    %{survey | title: title}
  end
end
