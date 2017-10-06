use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :track_user_agents, TrackUserAgentsWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :track_user_agents, TrackUserAgents.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "",
  database: "track_user_agents_phx13_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
