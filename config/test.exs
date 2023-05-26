import Config

# Ecto configuration
config :tortuga, Tortuga.Repo,
  database: System.get_env("TORTUGA_DB_DATABASE") || "tortuga_dev",
  username: System.get_env("TORTUGA_DB_USERNAME") || "tortuga",
  password: System.get_env("TORTUGA_DB_PASSWORD") || "tortuga",
  hostname: System.get_env("TORTUGA_DB_HOSTNAME") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :tortuga, ecto_repos: [Tortuga.Repo]
