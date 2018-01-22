defmodule Surveys.Aggregates.SurveyTest do
  use Surveys.DataCase

  alias Surveys.Authoring.Aggregates.Survey
  alias Surveys.Authoring.Events.{SurveyCreated, StatusChanged}
  alias Surveys.Authoring.Commands.{CreateSurvey, ChangeStatus}

  setup_all do
    {:ok, %{uuid: UUID.uuid4()}}
  end

  describe "survey aggregate" do
    # todo make case for this,
    # todo make factory for this
    test "create survey creates surveycreated event", %{uuid: uuid} do
      create_survey =
        %{title: "whatever", questions: []} |> CreateSurvey.new()
        |> CreateSurvey.assign_uuid(uuid)

      expected_event = %SurveyCreated{
        uuid: uuid,
        questions: [],
        title: "whatever",
        status: "DRAFT"
      }

      assert expected_event == Survey.execute(%Survey{}, create_survey)
    end

    test "change status emits proper event", %{uuid: uuid} do
      changed_survey =
        %{uuid: uuid, title: "whatever", status: "DRAFT", questions: []}
        |> ChangeStatus.new()
        |> ChangeStatus.change_status("PUBLISHED")

      expected_event = %StatusChanged{
        uuid: uuid,
        status: "PUBLISHED"
      }

      assert expected_event == Survey.execute(%Survey{}, changed_survey)
    end
  end
end
