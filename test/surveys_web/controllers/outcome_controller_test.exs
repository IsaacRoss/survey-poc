defmodule SurveysWeb.OutcomeControllerTest do
  use SurveysWeb.ConnCase

  alias Surveys.Authoring
  alias Surveys.Authoring.Outcome

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:outcome) do
    {:ok, outcome} = Authoring.create_outcome(@create_attrs)
    outcome
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all outcomes", %{conn: conn} do
      conn = get(conn, outcome_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create outcome" do
    test "renders outcome when data is valid", %{conn: conn} do
      conn = post(conn, outcome_path(conn, :create), outcome: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, outcome_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "description" => "some description",
               "name" => "some name"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, outcome_path(conn, :create), outcome: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update outcome" do
    setup [:create_outcome]

    test "renders outcome when data is valid", %{conn: conn, outcome: %Outcome{id: id} = outcome} do
      conn = put(conn, outcome_path(conn, :update, outcome), outcome: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, outcome_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "description" => "some updated description",
               "name" => "some updated name"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, outcome: outcome} do
      conn = put(conn, outcome_path(conn, :update, outcome), outcome: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete outcome" do
    setup [:create_outcome]

    test "deletes chosen outcome", %{conn: conn, outcome: outcome} do
      conn = delete(conn, outcome_path(conn, :delete, outcome))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, outcome_path(conn, :show, outcome))
      end)
    end
  end

  defp create_outcome(_) do
    outcome = fixture(:outcome)
    {:ok, outcome: outcome}
  end
end
