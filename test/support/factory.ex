defmodule Surveys.Factory do
  use ExMachina

  alias Surveys.Authoring.Commands.{CreateSurvey, ChangeStatus, ChangeTitle}
  alias Surveys.ContactManagement.Commands.{CreateContact}

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

  def change_title_factory do
    struct(ChangeTitle, build(:survey))
  end

  def contact_factory do
    %{
      email: "contact@taskstream.com"
    }
  end

  def create_contact_factory do
    struct(CreateContact, build(:contact))
  end

  def delete_contact_factory do
      struct(%{})
  end
end
