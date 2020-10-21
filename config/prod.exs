use Mix.Config

config :bybit,
  api_key: System.get_env("BYBIT_API_KEY"),
  api_secret: System.get_env("BYBIT_API_SECRET")
