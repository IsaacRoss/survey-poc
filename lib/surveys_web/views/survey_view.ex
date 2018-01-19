defmodule SurveysWeb.SurveyView do
  use SurveysWeb, :view
  alias SurveysWeb.SurveyView

  def render("index.json", %{surveys: surveys}) do
    %{data: render_many(surveys, SurveyView, "survey.json")}
  end

  def render("show.json", %{survey: survey}) do
    %{data: render_one(survey, SurveyView, "survey.json")}
  end

  def render("survey.json", %{survey: survey}) do
    %{id: survey.uuid, title: survey.title, questions: survey.questions}
  end
end
