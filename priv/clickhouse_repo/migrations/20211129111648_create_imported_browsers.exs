defmodule Plausible.ClickhouseRepo.Migrations.CreateImportedBrowsers do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:imported_browsers, engine: "MergeTree() ORDER BY (site_id, timestamp) SETTINGS index_granularity = 1") do
      add :site_id, :UInt64
      add :timestamp, :date
      add :browser, :string
      add :visitors, :UInt64
      add :visits, :UInt64
      add :visit_duration, :UInt64
      add :bounces, :UInt32
    end
  end
end
