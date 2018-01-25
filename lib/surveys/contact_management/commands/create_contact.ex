defmodule Surveys.ContactManagement.Commands.CreateContact do
  defstruct contact_uuid: "",
            email: "",
            username: ""

  alias Surveys.ContactManagement.Validators.UniqueEmail
  alias Surveys.ContactManagement.Commands.CreateContact

  use ExConstructor
  use Vex.Struct

  validates(:username, by: &String.valid?(&1))

  validates(
    :email,
    presence: [message: "can't be empty"],
    format: [with: ~r/\S+@\S+\.\S+/, allow_nil: true, allow_blank: true, message: "is invalid"],
    by: &UniqueEmail.validate/2
  )

  def assign_uuid(%CreateContact{} = created, uuid) do
    %CreateContact{created | contact_uuid: uuid}
  end

  def downcase_email(%CreateContact{email: email} = created) do
    %CreateContact{created | email: String.downcase(email)}
  end
end
