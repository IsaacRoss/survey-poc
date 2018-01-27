defmodule Surveys.Aggregates.SurveyTest do
  use Surveys.AggregateCase, aggregate: Surveys.Authoring.Aggregates.Survey

  alias Surveys.Authoring.Events.{SurveyCreated, StatusChanged, TitleChanged}

  setup_all do
    {:ok, %{uuid: UUID.uuid4()}}
  end

  describe "survey aggregate" do
    # todo make case for this,
    test "create survey creates surveycreated event", %{uuid: uuid} do
      assert_events(build(:create_survey, survey_uuid: uuid), [
        %SurveyCreated{
          survey_uuid: uuid,
          questions: [%{title: "whatever"}],
          title: "My Awesome Survey",
          status: "DRAFT"
        }
      ])
    end

    test "change status emits proper event", %{uuid: uuid} do
      assert_events(build(:change_status, survey_uuid: uuid, status: "PUBLISHED"), [
        %StatusChanged{
          survey_uuid: uuid,
          status: "PUBLISHED"
        }
      ])
    end

    test "update surveys emits title changed when title is updated", %{uuid: uuid} do
      assert_events(build(:update_survey, title: "new title"), [
        %TitleChanged{
          survey_uuid: nil,
          title: "new title"
        }
      ])
    end

    test "update surveys emits all events when multiple pieces updated", %{uuid: uuid} do
      assert_events(
        build(:update_survey, survey_uuid: uuid, title: "my new title", status: "PUBLISHED"),
        [
          %StatusChanged{
            survey_uuid: nil,
            status: "PUBLISHED"
          },
          %TitleChanged{
            survey_uuid: nil,
            title: "my new title"
          }
        ]
      )
    end
  end
end
