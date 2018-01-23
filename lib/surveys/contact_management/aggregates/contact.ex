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

  def execute(%Contact{}, %DeleteContact{uuid: uuid}) do
    %ContactDeleted{uuid: uuid}
  end

  def apply(%Contact{} = contact, %ContactCreated{} = created) do
    IO.inspect(contact)

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
