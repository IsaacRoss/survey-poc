defmodule SurveysWeb.OutcomeView do
  use SurveysWeb, :view
  alias SurveysWeb.OutcomeView

  def render("index.json", %{outcomes: outcomes}) do
    %{data: render_many(outcomes, OutcomeView, "outcome.json")}
  end

  def render("show.json", %{outcome: outcome}) do
    %{data: render_one(outcome, OutcomeView, "outcome.json")}
  end

  def render("outcome.json", %{outcome: outcome}) do
    %{id: outcome.id, name: outcome.name, description: outcome.description}
  end
end
