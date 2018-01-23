defmodule Surveys.ContactManagement.Aggregates.Contact do
  defstruct [
    :uuid,
    :email
  ]

  alias Surveys.ContactManagement.Aggregates.Contact
  alias Surveys.ContactManagement.Commands.{CreateContact, DeleteContact}
  alias Surveys.ContactManagement.Events.{ContactCreated, ContactDeleted}

  @doc """
  Create a new contact draft
  """
  def execute(%Contact{uuid: nil}, %CreateContact{} = create) do
    %ContactCreated{
      contact_uuid: create.contact_uuid,
      email: create.email
    }
  end

  def execute(%Contact{}, %DeleteContact{contact_uuid: uuid}) do
    %ContactDeleted{contact_uuid: uuid}
  end

  def apply(%Contact{} = contact, %ContactCreated{} = created) do
    %Contact{
      contact
      | uuid: created.contact_uuid,
        email: created.email
    }
  end

  def apply(%Contact{} = contact, %ContactDeleted{} = deleted) do
    %Contact{
      contact
      | uuid: deleted.contact_uuid
    }
  end
end
