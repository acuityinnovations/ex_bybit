defmodule Bybit.Auth do
  @moduledoc false
  @spec timestamp :: String.t()
  def timestamp do
    :os.system_time(:millisecond)
  end

  @spec sign(String.t(), map | [map], String.t(), String.t()) :: String.t()
  def sign(timestamp, body, api_key, api_secret) do
    payload_to_sign =
      body
      |> Map.put(:api_key, api_key)
      |> Map.put(:timestamp, timestamp)
      |> Enum.reduce(%{}, fn({k, v}, acc) -> Map.put(acc, k, v) end )
      |> URI.encode_query()

    :sha256
    |> :crypto.hmac(api_secret, payload_to_sign)
    |> Base.encode16()
  end
end
