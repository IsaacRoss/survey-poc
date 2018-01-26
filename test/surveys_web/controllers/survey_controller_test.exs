defmodule SurveysWeb.SurveyControllerTest do
  use SurveysWeb.ConnCase

  @valid_survey_attrs build(:survey)

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create survey" do
    test "should create and return survey when valid", %{conn: conn} do
      conn = post(conn, survey_path(conn, :create), survey: @valid_survey_attrs)
      json = json_response(conn, 201)["data"]

      assert json == %{
               "title" => "My Awesome Survey",
               "questions" => [%{"title" => "whatever"}]
             }
    end
  end
end
