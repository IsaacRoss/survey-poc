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
      uuid: create.uuid,
      email: create.email
    }
  end

  def apply(%Contact{} = contact, %ContactCreated{} = created) do
    %Contact{
      contact
      | uuid: created.uuid,
        email: created.email
    }
  end

  def apply(%Contact{} = contact, %ContactDeleted{} = deleted) do
    %Contact{
      contact
      | uuid: deleted.uuid
    }
  end

end
