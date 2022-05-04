import Config

# Read from environment variables
config :bybit,
  api_key: System.get_env("BYBIT_API_KEY"),
  api_secret: System.get_env("BYBIT_API_SECRET")

# Or replace "BYBIT_*" values to define here in config file
# config :bybit, api_key:        {:system, "BYBIT_API_KEY"},
#                api_secret:     {:system, "BYBIT__API_SECRET"}
