defmodule TrackUserAgents.Repo.Migrations.CreateSummaries do
  use Ecto.Migration

  def change do
    create table(:summaries) do
      add :os, :string
      add :total, :integer
      timestamps()
    end

    create unique_index(:summaries, [:os])
  end
end
