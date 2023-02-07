import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ex2048, Ex2048.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ex2048_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ex2048, Ex2048Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "OI2eL0PVdk4zvbp4rKRdyt/22z/9Aw9WQYx0WIGrKcQasPBA4wIrDb8EsTRf+OU8",
  server: false

# In test we don't send emails.
config :ex2048, Ex2048.Mailer, adapter: Swoosh.Adapters.Test

# Show only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
