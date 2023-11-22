import Config

config :api,
  port: 8080

config :api, Api.Repo,
  database: "ecommerce",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :api, :ecto_repos, [Api.Repo]

import_config "#{Mix.env()}.exs"
