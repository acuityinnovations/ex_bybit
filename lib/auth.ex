defmodule Bybit.Auth do
  @moduledoc false
  @spec timestamp :: String.t()
  def timestamp do
    :os.system_time(:millisecond)
  end

  def post_sign(timestamp, body, api_key, api_secret) do
    payload_to_sign = "#{timestamp}#{api_key}5000#{Jason.encode!(body)}"
    if Code.ensure_loaded?(:crypto) and function_exported?(:crypto, :mac, 4) do
      :hmac
      |> :crypto.mac(:sha256, api_secret, payload_to_sign)
      |> Base.encode16()
    else
      :sha256
      |> :crypto.hmac(api_secret, payload_to_sign)
      |> Base.encode16()
    end
  end

  def get_sign(timestamp, params, api_key, api_secret) do
    payload_to_sign = "#{timestamp}#{api_key}5000#{params|> URI.encode_query()}"
    if Code.ensure_loaded?(:crypto) and function_exported?(:crypto, :mac, 4) do
      :hmac
      |> :crypto.mac(:sha256, api_secret, payload_to_sign)
      |> Base.encode16()
    else
      :sha256
      |> :crypto.hmac(api_secret, payload_to_sign)
      |> Base.encode16()
    end
  end
end
