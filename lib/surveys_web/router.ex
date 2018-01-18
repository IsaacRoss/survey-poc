defmodule SurveysWeb.Router do
  use SurveysWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", SurveysWeb do
    pipe_through(:api)
  end
end
