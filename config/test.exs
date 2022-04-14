import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ze_delivery, ZeDelivery.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ze_delivery_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10,
  types: ZeDelivery.PostgresTypes

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ze_delivery, ZeDeliveryWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "e8BVbxljuZ7Go28RAwIqixB35DYFYjZNmWySf8gzW0QVzZd+3E82lB/74QQolD5j",
  server: false

# In test we don't send emails.
config :ze_delivery, ZeDelivery.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
