defmodule Bybit.Api.Private do
  @moduledoc """
  Interface for authenticated HTTP requests
  """

  import Bybit.Api
  alias Bybit.Config
  alias Bybit.Auth

  @type path :: String.t()
  @type params :: map | [map]
  @type config :: map | nil
  @type response :: Bybit.Api.response()

  @spec get(path, params, config) :: response
  def get(path, params \\ %{}, config \\ nil) do
    timestamp = Auth.timestamp()
    config = Config.config_or_env_config(config)
    signed = Auth.get_sign(timestamp, params, config.api_key, config.api_secret)
    qs = prepare_query_string(path, params)

    qs
    |> url(config)
    |> HTTPoison.get(headers(timestamp, signed, config))
    |> parse_response()
  end

  @spec post(path, params, config) :: response
  def post(path, params \\ %{}, config \\ nil) do
    timestamp = Auth.timestamp()
    config = Config.config_or_env_config(config)
    signed = Auth.post_sign(timestamp, params, config.api_key, config.api_secret)
    payload = prepare_payload(params)

    path
    |> url(config)
    |> HTTPoison.post(payload, headers(timestamp, signed, config))
    |> parse_response()
  end

  defp prepare_query_string(path, params) do
    query_string(path, params)
  end

  defp prepare_payload(body) do
    body
    |> Jason.encode!()
  end

  defp headers(timestamp, signed, config) do
    [
      "X-BAPI-SIGN-TYPE": 2,
      "X-BAPI-SIGN": signed,
      "X-BAPI-API-KEY": config.api_key,
      "X-BAPI-TIMESTAMP": timestamp,
      "X-BAPI-RECV-WINDOW": 5000,
      "Content-Type": "application/json"
    ]
  end
end
