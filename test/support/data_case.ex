defmodule Surveys.DataCase do
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
    Survey.Storage.reset!()

    :ok
  end
end
