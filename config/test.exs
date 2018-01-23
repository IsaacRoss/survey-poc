use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :surveys, SurveysWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure the event store database
config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "surveys_eventstore_test",
  hostname: "localhost",
  pool_size: 1

# Configure your database
config :surveys, Surveys.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "surveys_readstore_test",
  hostname: "localhost",
  pool_size: 1
