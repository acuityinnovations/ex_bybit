defmodule Bybit.Inverse.Private do
  @moduledoc """
  Inverse contract client.
  """

  import Bybit.Api.Private

  @type params :: map
  @type config :: map | nil
  @type response :: Bybit.Api.response()

  @prefix "/v2/private"

  @doc """
  Place a new order.

  ## Examples

  iex> Bybit.Inverse.Private.create_order(%{symbol: "BTCUSD",
    price: 11000,
    qty: 0.01,
    order_type: "Limit",
    side: "Buy",
    time_in_force: "PostOnly"
  })
  {:ok,
   %{
     "client_oid" => nil,
     "error_code" => "0",
     "error_message" => "",
     "order_id" => "465681883218518016",
     "result" => "true"
   }}
  """
  @spec create_order(params, config) :: response
  def create_order(params, config \\ nil) do
    post("#{@prefix}/order/create", params, config)
  end

  @doc """
  Bybit.Inverse.Private.get_open_orders(%{symbol: "BTCUSD", order_status: "New"})

  {:ok,
   %{
     "ext_code" => "",
     "ext_info" => nil,
     "rate_limit" => 600,
     "rate_limit_reset_ms" => 1603300589851,
     "rate_limit_status" => 599,
     "result" => %{"current_page" => 1, "data" => [], "last_page" => 1},
     "ret_code" => 0,
     "ret_msg" => "ok",
     "time_now" => "1603300589.844809"
   }}
  """
  def get_open_orders(params, config \\ nil) do
    get("/open-api/order/list", params, config)
  end

  @doc """
  Bybit.Inverse.Private.cancel_order(%{symbol: "BTCUSD", order_id: "1234"})

  """
  def cancel_order(params, config \\ nil) do
    post("#{@prefix}/order/cancel", params, config)
  end
end
