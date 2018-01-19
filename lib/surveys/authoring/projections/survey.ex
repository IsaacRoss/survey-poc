defmodule Surveys.Authoring.Projections.Survey do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "authoring_surveys" do
    field(:title, :string)
    field(:questions, {:array, :map})
    field(:status, :string)

    timestamps()
  end
end
