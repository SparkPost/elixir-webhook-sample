defmodule TrackUserAgents.Summary do
  use Ecto.Schema
  import Ecto.Changeset
  alias TrackUserAgents.Summary


  schema "summaries" do
    field :os, :string
    field :total, :integer

    timestamps()
  end

  @doc false
  def changeset(%Summary{} = summary, attrs) do
    summary
    |> cast(attrs, [:os, :total])
    |> validate_required([:os, :total])
    |> unique_constraint(:os)
  end
end
