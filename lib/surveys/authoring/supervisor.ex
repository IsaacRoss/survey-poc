defmodule Surveys.Authoring.Supervisor do
  use Supervisor

  alias Surveys.Authoring

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init([
      Authoring.Projectors.SurveyDraft
    ], strategy: :one_for_one)
  end
end
