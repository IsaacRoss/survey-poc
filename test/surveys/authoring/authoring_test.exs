defmodule Surveys.Aggregates.SurveyTest do
  use Surveys.AggregateCase, aggregate: Surveys.Authoring.Aggregates.Survey

  alias Surveys.Authoring.Events.{SurveyCreated, StatusChanged}

  setup_all do
    {:ok, %{uuid: UUID.uuid4()}}
  end

  describe "survey aggregate" do
    # todo make case for this,
    test "create survey creates surveycreated event", %{uuid: uuid} do
      assert_event(build(:create_survey, survey_uuid: uuid), %SurveyCreated{
        survey_uuid: uuid,
        questions: [%{title: "whatever"}],
        title: "My Awesome Survey",
        status: "DRAFT"
      })
    end

    test "change status emits proper event", %{uuid: uuid} do
      assert_event(build(:change_status, survey_uuid: uuid, status: "PUBLISHED"), %StatusChanged{
        survey_uuid: uuid,
        status: "PUBLISHED"
      })
    end
  end
end
