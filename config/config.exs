import Config

# Ecto configuration
config :tortuga, Tortuga.Repo,
  database: System.get_env("TORTUGA_DB_DATABASE") || "tortuga_dev",
  username: System.get_env("TORTUGA_DB_USERNAME") || "tortuga",
  password: System.get_env("TORTUGA_DB_PASSWORD") || "tortuga",
  hostname: System.get_env("TORTUGA_DB_HOSTNAME") || "localhost"

config :tortuga, ecto_repos: [Tortuga.Repo]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
if File.exists?("config/#{Mix.env()}.exs") do
  import_config "#{Mix.env()}.exs"
end
