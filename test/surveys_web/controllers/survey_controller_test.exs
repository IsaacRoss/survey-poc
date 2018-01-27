defmodule SurveysWeb.SurveyControllerTest do
  use SurveysWeb.ConnCase

  alias Surveys.Authoring
  alias Surveys.Authoring.Projections.Surveys

  @valid_survey_attrs build(:survey)
  @invalid_survey_atts %{title: "this is it"}

  def fixture(:survey) do
    {:ok, survey} = build(:survey) |> Authoring.create_survey()
    {:ok, [survey: survey]}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create survey" do
    test "should create and return survey when valid", %{conn: conn} do
      conn = post(conn, survey_path(conn, :create), survey: @valid_survey_attrs)
      json = json_response(conn, 201)["data"]

      assert Map.get(json, "title") == "My Awesome Survey"
      assert Map.get(json, "questions") == [%{"title" => "whatever"}]
    end

    test "should get 422 and return errors when survey when invalid", %{conn: conn} do
      conn = post(conn, survey_path(conn, :create), survey: @invalid_survey_atts)
      json = json_response(conn, 422)["errors"]

      assert json = %{
               "questions" => ["must have length of at least 1"]
             }
    end
  end

  describe "update survey" do
    setup do
      fixture(:survey)
    end

    test "should update return survey when valid", %{conn: conn, survey: survey} do
      conn =
        put(
          conn,
          survey_path(conn, :update, survey.uuid),
          survey: %{survey | title: "this title is way better"}
        )

      json = json_response(conn, 200)["data"]

      assert Map.get(json, "title") == "this title is way better"
      assert Map.get(json, "questions") == [%{"title" => "whatever"}]
    end

    test "should get 422 and return errors when survey when invalid", %{
      conn: conn,
      survey: survey
    } do
      updated = %{survey | title: ""}
      conn = put(conn, survey_path(conn, :update, survey.uuid), survey: updated)

      json = json_response(conn, 422)["errors"]

      assert json == %{"title" => ["can't be empty"]}
    end
  end
end
