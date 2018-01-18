defmodule Surveys.AuthoringTest do
  use Surveys.DataCase

  alias Surveys.Authoring

  describe "outcomes" do
    alias Surveys.Authoring.Outcome

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def outcome_fixture(attrs \\ %{}) do
      {:ok, outcome} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authoring.create_outcome()

      outcome
    end

    test "list_outcomes/0 returns all outcomes" do
      outcome = outcome_fixture()
      assert Authoring.list_outcomes() == [outcome]
    end

    test "get_outcome!/1 returns the outcome with given id" do
      outcome = outcome_fixture()
      assert Authoring.get_outcome!(outcome.id) == outcome
    end

    test "create_outcome/1 with valid data creates a outcome" do
      assert {:ok, %Outcome{} = outcome} = Authoring.create_outcome(@valid_attrs)
      assert outcome.description == "some description"
      assert outcome.name == "some name"
    end

    test "create_outcome/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authoring.create_outcome(@invalid_attrs)
    end

    test "update_outcome/2 with valid data updates the outcome" do
      outcome = outcome_fixture()
      assert {:ok, outcome} = Authoring.update_outcome(outcome, @update_attrs)
      assert %Outcome{} = outcome
      assert outcome.description == "some updated description"
      assert outcome.name == "some updated name"
    end

    test "update_outcome/2 with invalid data returns error changeset" do
      outcome = outcome_fixture()
      assert {:error, %Ecto.Changeset{}} = Authoring.update_outcome(outcome, @invalid_attrs)
      assert outcome == Authoring.get_outcome!(outcome.id)
    end

    test "delete_outcome/1 deletes the outcome" do
      outcome = outcome_fixture()
      assert {:ok, %Outcome{}} = Authoring.delete_outcome(outcome)
      assert_raise Ecto.NoResultsError, fn -> Authoring.get_outcome!(outcome.id) end
    end

    test "change_outcome/1 returns a outcome changeset" do
      outcome = outcome_fixture()
      assert %Ecto.Changeset{} = Authoring.change_outcome(outcome)
    end
  end
end
