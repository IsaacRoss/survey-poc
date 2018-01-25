defmodule Surveys.ContactManagement.Projections.Contact do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "contact_management" do
    field(:email)
    field(:username)
    timestamps()
  end
end
