import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ex2048, Ex2048Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "jh0tlE/8NXfWe0Qnsx3ogKjAQ0j1lkeIXL3IEAPoMpy4OfvOj8Z3PNLJM0XGGwI3",
  server: false

# In test we don't send emails.
config :ex2048, Ex2048.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
