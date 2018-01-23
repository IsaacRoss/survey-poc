defmodule Surveys.ContactManagement.Projectors.Contact do
  use Commanded.Projections.Ecto,
    name: "ContactManagement.Projectors.Contact",
    repo: Surveys.Repo,
    consistency: :strong

  alias Surveys.ContactManagement.Events.{ContactCreated, ContactDeleted}
  alias Surveys.ContactManagement.Projections.Contact

  project %ContactCreated{} = created do
    Ecto.Multi.insert(multi, :contact, %Contact{
      uuid: created.uuid,
      email: created.email
    })
  end

  project %ContactDeleted{} = deleted do
    Ecto.Multi.delete(multi, :contact, %Contact{
      uuid: deleted.uuid
    })
  end
end
