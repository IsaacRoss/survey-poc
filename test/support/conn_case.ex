defmodule SurveysWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import SurveysWeb.Router.Helpers
      import Surveys.Factory

      # The default endpoint for testing
      @endpoint SurveysWeb.Endpoint
    end
  end

  setup _tags do
    Surveys.Storage.reset!()

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
