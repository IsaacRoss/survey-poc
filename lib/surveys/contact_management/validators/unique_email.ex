defmodule Surveys.ContactManagement.Validators.UniqueEmail do
  use Vex.Validator

  alias Surveys.ContactManagement
  alias Surveys.ContactManagement.Projections.Contact

  def validate(email, context) do
    uuid = Map.get(context, :contact_uuid)

    case email_taken(email, uuid) do
      true -> {:error, "has already been taken"}
      false -> :ok
    end
  end

  defp email_taken(email, uuid) do
    case ContactManagement.contact_by_email(email) do
      %Contact{uuid: ^uuid} -> false
      nil -> false
      _ -> true
    end
  end
end
