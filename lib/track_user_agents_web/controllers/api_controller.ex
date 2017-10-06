defmodule TrackUserAgentsWeb.ApiController do
  use TrackUserAgentsWeb, :controller
  import Ecto.Query
  alias TrackUserAgents.Summary
  alias TrackUserAgents.Repo
  require Logger

  def report(conn, _params) do
    # Extract and return all summaries as [[os, total], ...]
    get_summaries = from(s in Summary, select: [s.os, s.total])
    summaries = Repo.all(get_summaries)
    Logger.debug("#{inspect(summaries)}")
    json conn, summaries
  end

  def webhook(conn, _params) do
    events = conn.assigns[:events]

    # Group events by OS
    osgroups = Enum.group_by(events, &(&1["os"]))

    # Count members of each group
    # Build summary records
    recs = Enum.map(osgroups, fn({k, v}) ->
      %Summary{os: k, total: Enum.count(v)} end
    )

    # Upsert a single record
    upsert_fn = fn rec -> Repo.insert(rec,
                    on_conflict: [inc: [total: rec.total]],
                    conflict_target: :os)
    end

    # Update all effected records in a transaction
    Repo.transaction(fn -> Enum.map(recs, upsert_fn) end)

    # Happiness is...
    json conn, %{"ok": true}
  end
end

