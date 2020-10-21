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
    config = Config.config_or_env_config(config)
    qs = prepare_query_string(path, params, config)

    qs
    |> url(config)
    |> HTTPoison.get(headers())
    |> parse_response()
  end

  @spec post(path, params, config) :: response
  def post(path, params \\ %{}, config \\ nil) do
    config = Config.config_or_env_config(config)
    payload = prepare_payload(params, config)

    path
    |> url(config)
    |> HTTPoison.post(payload, headers())
    |> parse_response()
  end

  @spec delete(path, config) :: response
  def delete(path, config \\ nil) do
    config = Config.config_or_env_config(config)

    path
    |> url(config)
    |> HTTPoison.delete(headers())
    |> parse_response()
  end

  defp prepare_query_string(path, params, config) do
    timestamp = Auth.timestamp()
    signed = Auth.sign(timestamp, params, config.api_key, config.api_secret)

    updated_params =
      params
      |> Map.put(:api_key, config.api_key)
      |> Map.put(:timestamp, timestamp)
      |> Map.put(:sign, signed)

    query_string(path, updated_params)
  end

  defp prepare_payload(body, config) do
    timestamp = Auth.timestamp()
    signed = Auth.sign(timestamp, body, config.api_key, config.api_secret)

    body
    |> Map.put(:api_key, config.api_key)
    |> Map.put(:timestamp, timestamp)
    |> Map.put(:sign, signed)
    |> Jason.encode!()
  end

  defp headers() do
    [
      "Content-Type": "application/json"
    ]
  end
end
