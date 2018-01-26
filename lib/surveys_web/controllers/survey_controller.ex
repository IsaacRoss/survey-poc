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

  def update(conn, %{"uuid" => survey_uuid, "survey" => updated_survey}) do
    updated = %Survey{uuid: survey_uuid}

    with {:ok, %Survey{} = survey} <- Authoring.update_survey(updated, updated_survey) do
      conn
      |> put_status(:ok)
      |> render("show.json", survey: survey)
    end
  end
end
