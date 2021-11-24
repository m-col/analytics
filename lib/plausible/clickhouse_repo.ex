defmodule Plausible.ClickhouseRepo do
  use Ecto.Repo,
    otp_app: :plausible,
    adapter: ClickhouseEcto

  defmacro __using__(_) do
    quote do
      alias Plausible.ClickhouseRepo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]
    end
  end

  def clear_stats_for(domain) do
    events_sql = "ALTER TABLE events DELETE WHERE domain = ?"
    sessions_sql = "ALTER TABLE sessions DELETE WHERE domain = ?"
    Ecto.Adapters.SQL.query!(__MODULE__, events_sql, [domain])
    Ecto.Adapters.SQL.query!(__MODULE__, sessions_sql, [domain])
  end

  def clear_imported_stats_for(domain) do
    visitors_sql = "ALTER TABLE imported_visitors DELETE WHERE domain = ?"
    sources_sql = "ALTER TABLE imported_sources DELETE WHERE domain = ?"
    utm_mediums_sql = "ALTER TABLE imported_utm_mediums DELETE WHERE domain = ?"
    utm_campaigns_sql = "ALTER TABLE imported_utm_campaigns DELETE WHERE domain = ?"
    Ecto.Adapters.SQL.query!(__MODULE__, visitors_sql, [domain])
    Ecto.Adapters.SQL.query!(__MODULE__, sources_sql, [domain])
    Ecto.Adapters.SQL.query!(__MODULE__, utm_mediums_sql, [domain])
    Ecto.Adapters.SQL.query!(__MODULE__, utm_campaigns_sql, [domain])
  end
end
