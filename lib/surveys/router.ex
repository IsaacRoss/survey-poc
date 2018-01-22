defmodule Surveys.Router do
  use Commanded.Commands.Router

  alias Surveys.Authoring.Aggregates.Survey
  alias Surveys.Authoring.Commands.{CreateSurvey, ChangeStatus}
  alias Surveys.ContactManagement.Aggregates.Contact
  alias Surveys.ContactManagement.Commands.{CreateContact, DeleteContact}

  alias Surveys.Middleware.Validate

  middleware(Validate)

  dispatch(
    [
      CreateSurvey,
      ChangeStatus
    ],
    to: Survey,
    identity: :uuid
  )

  dispatch(
    [
      CreateContact,
      DeleteContact
    ],
    to: Contact,
    identity: :uuid
  )

end
