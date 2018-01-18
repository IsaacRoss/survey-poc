defmodule Survey.Authoring.Projections.Outcome do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "authoring_outcomes" do
    field(:name, :string)
    field(:description, :string)
    field(:met_text, :string)
    field(:not_met_text, :string)

    timestamps()
  end
end
