defmodule Surveys.Aggregates.SurveyTest do
  use Surveys.AggregateCase, aggregate: Surveys.Authoring.Aggregates.Survey

  alias Surveys.Authoring.Events.{SurveyCreated, StatusChanged}

  setup_all do
    {:ok, %{uuid: UUID.uuid4()}}
  end

  describe "survey aggregate" do
    # todo make case for this,
    test "create survey creates surveycreated event", %{uuid: uuid} do
      assert_event(build(:create_survey, uuid: uuid), %SurveyCreated{
        uuid: uuid,
        questions: [%{title: "whatever"}],
        title: "My Awesome Survey",
        status: "DRAFT"
      })
    end

    test "change status emits proper event", %{uuid: uuid} do
      assert_event(build(:change_status, uuid: uuid, status: "PUBLISHED"), %StatusChanged{
        uuid: uuid,
        status: "PUBLISHED"
      })
    end
  end
end
