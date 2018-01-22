defmodule SurveysWeb.SurveyController do
  use SurveysWeb, :controller

  alias Surveys.Authoring
  alias Surveys.Authoring.Projections.Survey

  action_fallback(SurveysWeb.FallbackController)

  def create(conn, %{"survey" => survey_params}) do
    with {:ok, %Survey{} = survey} <- Authoring.create_survey(survey_params) do
      conn
      |> put_status(:created)
      |> render("show.json", survey: survey)
    end
  end

  def change_title(conn, %{"uuid" => uuid, "title" => title}) do
    with {:ok, %Survey{} = survey} <- Authoring.change_title(uuid, title) do
      conn
      |> put_status(:created)
      |> render("show.json", survey: survey)
    end
  end
end
