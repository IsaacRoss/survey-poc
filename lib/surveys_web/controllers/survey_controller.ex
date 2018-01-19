defmodule SurveysWeb.SurveyController do
  use SurveysWeb, :controller

  alias Surveys.Authoring
  alias Surveys.Authoring.Projections.Survey

  def create(conn, %{"survey" => survey_params}) do
    with {:ok, %Survey{} = survey} <- Authoring.create_survey(survey_params) do
      conn
      |> put_status(:created)
      |> render("show.json", survey: survey)
    end
  end
end
