defmodule Surveys.Repo.Migrations.ContactManagement do
  use Ecto.Migration

  def change do
    create table(:contact_management, primary_key: false) do
      add(:uuid, :uuid, primary_key: true)
      add(:email, :string)
      add(:username, :string)

      timestamps()
    end
  end
end
