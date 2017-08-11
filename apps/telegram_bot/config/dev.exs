use Mix.Config
import_config "#{Mix.env}.secret.exs"

# config :nadia,
#   token: ""

# config :telegram_bot, 
#   bot_name: "",
#   redis_uri: ""

config :telegram_bot, :environment, :dev
