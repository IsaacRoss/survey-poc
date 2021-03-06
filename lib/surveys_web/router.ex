defmodule SurveysWeb.Router do
  use SurveysWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", SurveysWeb do
    pipe_through(:api)

    post("/survey", SurveyController, :create)
    put("/survey/:uuid", SurveyController, :update)

    post("/contact", ContactController, :create)
  end
end
