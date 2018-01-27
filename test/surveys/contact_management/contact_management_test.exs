defmodule Surveys.Aggregates.ContactManagementTest do
  use Surveys.AggregateCase, aggregate: Surveys.ContactManagement.Aggregates.Contact

  alias Surveys.ContactManagement.Events.{ContactCreated, ContactDeleted}

  setup_all do
    {:ok, %{uuid: UUID.uuid4()}}
  end

  describe "contact aggregate" do
    test "create contact creates ContactCreated event", %{uuid: uuid} do
      assert_events(build(:create_contact, contact_uuid: uuid), [
        %ContactCreated{
          contact_uuid: uuid,
          email: "contact@taskstream.com"
        }
      ])
    end

    test "delete contact creates ContactDeleted event", %{uuid: uuid} do
      assert_events(build(:delete_contact, contact_uuid: uuid), [
        %ContactDeleted{
          contact_uuid: uuid
        }
      ])
    end
  end
end
