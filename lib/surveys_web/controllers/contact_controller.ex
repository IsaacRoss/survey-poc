defmodule SurveysWeb.ContactController do
  use SurveysWeb, :controller

  alias Surveys.ContactManagement
  alias Surveys.ContactManagement.Projections.Contact

  action_fallback(SurveysWeb.FallbackController)

  def create(conn, %{"contact" => params}) do
    with {:ok, %Contact{} = contact} <- ContactManagement.create_contact(params) do
      conn
      |> put_status(:created)
      |> render("show.json", contact: contact)
    end
  end

end
