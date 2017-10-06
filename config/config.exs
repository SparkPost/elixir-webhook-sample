# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :track_user_agents,
  ecto_repos: [TrackUserAgents.Repo]

# Configures the endpoint
config :track_user_agents, TrackUserAgentsWeb.Endpoint,
  url: [host: "localhost"],

  # Warning: unsafe at any speed
  secret_key_base: "sZRnvB3YoEkNz3aMZh19GKqh+eJ5WHj2/3y+Nsal0pqeAFvxvBGvfRXASXVOyhDd",
  render_errors: [view: TrackUserAgentsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TrackUserAgents.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ua_inspector,
  database_path: "priv/ua_inspector"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
