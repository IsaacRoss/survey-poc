defmodule Surveys.Aggregates.ContactManagementTest do
  use Surveys.AggregateCase, aggregate: Surveys.ContactManagement.Aggregates.Contact

  alias Surveys.ContactManagement.Events.{ContactCreated, ContactDeleted}

  setup_all do
    {:ok, %{uuid: UUID.uuid4()}}
  end

  describe "contact aggregate" do
    test "create contact creates ContactCreated event", %{uuid: uuid} do
      assert_event(build(:create_contact, uuid: uuid), %ContactCreated{
        uuid: uuid,
        email: "contact@taskstream.com"
      })
    end

    # test "delete contact creates ContactDeleted event", %{uuid: uuid} do
    #   delete_contact = build(:delete_contact, uuid: uuid)
    #
    #   expected_event = %ContactDeleted{
    #     uuid: uuid
    #   }
    #
    #   assert expected_event ==
    #     Contact.execute(%Contact{}, delete_contact)
    #   end
  end
end
