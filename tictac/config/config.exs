# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tictac,
  ecto_repos: [Tictac.Repo]

# Configures the endpoint
config :tictac, TictacWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5V3H/OOQAIpX3C3ZUuVq6VnnkhY0qx2SkNaE1XVAMSjCqJESfg7e/re1oDXOZwZG",
  render_errors: [view: TictacWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Tictac.PubSub,
  live_view: [signing_salt: "n/4YanI1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
