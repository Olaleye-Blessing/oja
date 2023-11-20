import Config

config :api,
  port: 8080

import_config "#{Mix.env()}.exs"
