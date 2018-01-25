defmodule Surveys.ContactManagement do
  @moduledoc """
  The Contact Management context
  """

  alias Surveys.ContactManagement.Commands.{CreateContact, DeleteContact}
  alias Surveys.ContactManagement.Projections.Contact
  alias Surveys.ContactManagement.Queries.ContactByEmail
  alias Surveys.{Repo, Router}

  def create_contact(attrs \\ {}) do
    uuid = UUID.uuid4()

    created_contact =
      attrs
      |> CreateContact.new()
      |> CreateContact.assign_uuid(uuid)
      |> CreateContact.downcase_email()

    with :ok <- Router.dispatch(created_contact, consistency: :strong) do
      get(Contact, uuid)
    else
      reply -> reply
    end
  end

  def delete_contact(uuid) do
    %{}
    |> DeleteContact.new()
    |> DeleteContact.assign_uuid(uuid)
    |> Router.dispatch()
  end

  def contact_by_email(email) do
    email
    |> ContactByEmail.new()
    |> Repo.one()
  end

  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
