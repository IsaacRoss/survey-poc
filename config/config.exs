# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :surveys, ecto_repos: [Surveys.Repo]

# Configures the endpoint
config :surveys, SurveysWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oPash/vdJA7OIgtYhnUX46BkXcIzdr9vYtLAKE7wE/fl9sWThlQeI9th5uD3/jyu",
  render_errors: [view: SurveysWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Surveys.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :commanded, event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :vex, sources: [Vex.Validators]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
