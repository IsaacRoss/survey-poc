defmodule Surveys.Storage do
  def reset! do
    IO.puts("RESETTING")
    :ok = Application.stop(:surveys)
    :ok = Application.stop(:commanded)
    :ok = Application.stop(:eventstore)

    # Get and parse config, start OTP app, delete shit
    reset_eventstore()
    reset_readstore()

    {:ok, _} = Application.ensure_all_started(:surveys)
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
    contact_management,
    projection_versions

    RESTART IDENTITY;
    """
  end
end
