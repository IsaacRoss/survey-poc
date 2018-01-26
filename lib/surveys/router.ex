defmodule Surveys.Router do
  use Commanded.Commands.Router

  alias Surveys.Authoring.Aggregates.Survey
  alias Surveys.Authoring.Commands.{CreateSurvey, ChangeStatus, UpdateSurvey}
  alias Surveys.ContactManagement.Aggregates.Contact
  alias Surveys.ContactManagement.Commands.{CreateContact, DeleteContact}

  alias Surveys.Support.Middleware.Validate

  middleware(Validate)

  identify(Survey, by: :survey_uuid, prefix: "survey-")
  identify(Contact, by: :contact_uuid, prefix: "contact-")

  dispatch(
    [
      CreateSurvey,
      ChangeStatus,
      UpdateSurvey
    ],
    to: Survey
  )

  dispatch(
    [
      CreateContact,
      DeleteContact
    ],
    to: Contact,
    lifespan: Contact
  )
end
