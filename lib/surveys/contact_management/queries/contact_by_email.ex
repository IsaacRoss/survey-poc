defmodule Surveys.ContactManagement.Queries.ContactByEmail do
  import Ecto.Query

  alias Surveys.ContactManagement.Projections.Contact

  def new(email) do
    from(c in Contact, where: c.email == ^email)
  end
end
