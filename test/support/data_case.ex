defmodule Surveys.DataCase do
  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's data layer.

  You may define functions here to be used as helpers in
  your tests.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias Surveys.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Surveys.Factory
      import Surveys.DataCase
    end
  end

  setup do
    Application.stop(:surveys)
    Application.stop(:commanded)
    Application.stop(:eventstore)

    # Get and parse config, start OTP app, delete shit
    reset_eventstore()
    reset_readstore()

    Application.ensure_all_started(:surveys)

    :ok
  end

  @doc """
  A helper that transform changeset errors to a map of messages.

      assert {:error, changeset} = Accounts.create_user(%{password: "short"})
      assert "password is too short" in errors_on(changeset).password
      assert %{password: ["password is too short"]} = errors_on(changeset)

  """
  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Enum.reduce(opts, message, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  # https://hexdocs.pm/eventstore/EventStore.Storage.html#reset!/0
  defp reset_eventstore do
    {:ok, conn} =
      EventStore.configuration()
      |> EventStore.Config.parse()
      |> Postgrex.start_link()

    EventStore.Storage.Initializer.reset!(conn)
  end

  defp reset_readstore do
    readstore_config = Application.get_env(:surveys, Surveys.Repo)
    {:ok, conn} = Postgrex.start_link(readstore_config)

    Postgrex.query!(conn, truncate_tables(), [])
  end

  defp truncate_tables do
    """
    TRUNCATE TABLE
    authoring_surveys,
    contact_management

    RESTART IDENTITY;
    """
  end
end
