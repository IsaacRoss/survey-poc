defmodule SurveysWeb.OutcomeController do
  use SurveysWeb, :controller

  alias Surveys.Authoring
  alias Surveys.Authoring.Outcome

  action_fallback(SurveysWeb.FallbackController)

  def index(conn, _params) do
    outcomes = Authoring.list_outcomes()
    render(conn, "index.json", outcomes: outcomes)
  end

  def create(conn, %{"outcome" => outcome_params}) do
    with {:ok, %Outcome{} = outcome} <- Authoring.create_outcome(outcome_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", outcome_path(conn, :show, outcome))
      |> render("show.json", outcome: outcome)
    end
  end

  def show(conn, %{"id" => id}) do
    outcome = Authoring.get_outcome!(id)
    render(conn, "show.json", outcome: outcome)
  end

  def update(conn, %{"id" => id, "outcome" => outcome_params}) do
    outcome = Authoring.get_outcome!(id)

    with {:ok, %Outcome{} = outcome} <- Authoring.update_outcome(outcome, outcome_params) do
      render(conn, "show.json", outcome: outcome)
    end
  end

  def delete(conn, %{"id" => id}) do
    outcome = Authoring.get_outcome!(id)

    with {:ok, %Outcome{}} <- Authoring.delete_outcome(outcome) do
      send_resp(conn, :no_content, "")
    end
  end
end
