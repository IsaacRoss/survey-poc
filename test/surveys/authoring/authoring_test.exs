defmodule Surveys.Aggregates.SurveyTest do
  use Surveys.DataCase

  alias Surveys.Authoring.Aggregates.Survey
  alias Surveys.Authoring.Events.{SurveyCreated, StatusChanged}

  import Surveys.Factory

  setup_all do
    {:ok, %{uuid: UUID.uuid4()}}
  end

  describe "survey aggregate" do
    # todo make case for this,
    test "create survey creates surveycreated event", %{uuid: uuid} do
      create_survey = build(:create_survey, uuid: uuid)

      expected_event = %SurveyCreated{
        uuid: uuid,
        questions: [%{title: "whatever"}],
        title: "My Awesome Survey",
        status: "DRAFT"
      }

      assert expected_event == Survey.execute(%Survey{}, create_survey)
    end

    test "change status emits proper event", %{uuid: uuid} do
      changed_survey = build(:change_status, uuid: uuid, status: "PUBLISHED")

      expected_event = %StatusChanged{
        uuid: uuid,
        status: "PUBLISHED"
      }

      assert expected_event == Survey.execute(%Survey{}, changed_survey)
    end
  end
end
