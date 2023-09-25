import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :clingo_playground, ClingoPlaygroundWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "wMwXRK8BhSU9SVTuXAADmhAwgipRsTVFE+NLT7SkHQEQ2V5VYRnisv5Sh8SW3T+L",
  server: false

# In test we don't send emails.
config :clingo_playground, ClingoPlayground.Mailer,
  adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
