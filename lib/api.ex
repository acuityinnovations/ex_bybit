defmodule Bybit.Api do
  @moduledoc false
  @type path :: String.t()
  @type config :: map
  @type params :: map
  @type status_code :: integer
  @type body :: term
  @type response :: {:ok, term} | {:error, term} | {:error, body, status_code}

  @spec url(path, config) :: String.t()
  def url(path, config), do: config.api_url <> path

  @spec query_string(path, params) :: String.t()
  def query_string(path, params) when map_size(params) == 0, do: path

  def query_string(path, params) do
    query =
      params
      |> URI.encode_query()

    path <> "?" <> query
  end

  @spec parse_response(
          {:ok, HTTPoison.Response.t() | HTTPoison.AsyncResponse.t()}
          | {:error, HTTPoison.Error.t()}
        ) :: response
  def parse_response(response) do
    case response do
      {:ok, %HTTPoison.Response{body: body, status_code: _status_code}} ->
        {:ok, Jason.decode!(body)}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
