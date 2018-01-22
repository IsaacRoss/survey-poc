defmodule Surveys.Factory do
  use ExMachina

  alias Surveys.Authoring.Commands.{CreateSurvey, ChangeStatus}

  def survey_factory do
    %{
      title: "My Awesome Survey",
      questions: [%{title: "whatever"}]
    }
  end

  def create_survey_factory do
    struct(CreateSurvey, build(:survey))
  end

  def change_status_factory do
    struct(ChangeStatus, build(:survey))
  end
end
