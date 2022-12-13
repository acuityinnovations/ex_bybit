defmodule Bybit.Spot.Private do
  @moduledoc """
  Spot contract client.
  """

  import Bybit.Api.Private

  @type params :: map
  @type config :: map | nil
  @type response :: Bybit.Api.response()

  @prefix "/spot/v3/private"

  @doc """
  Place a new order.

  ## Examples

  iex> Bybit.Spot.Private.create_order(%{
    "symbol": "ETHUSDT",
    "orderQty":"0.001",
    "side": "Buy",
    "orderType": "LIMIT",
    "timeInForce": "GTC",
    "orderPrice": "333",
    "orderLinkId": "CJM00114"
  })
  {:ok,
   %{
    "retCode" => 0,
    "retMsg" => "OK",
    "result" => %{
        "orderId" => "1309923963809357056",
        "orderLinkId" => "CJM00314",
        "symbol" => "ETHUSDT",
        "createTime" => "1670891105091",
        "orderPrice" => "400",
        "orderQty" => "0.001",
        "orderType" => "LIMIT",
        "side" => "BUY",
        "status" => "NEW",
        "timeInForce" => "GTC",
        "accountId" => "1107450",
        "execQty" => "0",
        "orderCategory" => 0
    },
    "retExtInfo" => {},
    "time" => 1670891105099
  }}
  """
  def create_order(params, config \\ nil) do
    post("#{@prefix}/order", params, config)
  end

  @doc """
  Bybit.Spot.Private.get_open_orders(%{symbol: "ETHUSD"})

  {:ok,
   %{
    "retCode" => 0,
    "retMsg" => "OK",
    "result" => %{
        "list" => [
            {
                "accountId" => "1107450",
                "symbol" => "ETHUSDT",
                "orderLinkId" => "CJM010314",
                "orderId" => "1309931131036032256",
                "orderPrice" => "400",
                "orderQty" => "0.001",
                "execQty" => "0",
                "cummulativeQuoteQty" => "0",
                "avgPrice" => "0",
                "status" => "NEW",
                "timeInForce" => "GTC",
                "orderType" => "LIMIT",
                "side" => "BUY",
                "stopPrice" => "0.0",
                "icebergQty" => "0.0",
                "createTime" => 1670891959491,
                "updateTime" => 1670891959501,
                "isWorking" => "1",
                "orderCategory" => 0
            }
        ]
    },
    "retExtInfo" => {},
    "time" => 1670891962506
  }}
  """
  def get_open_orders(params, config \\ nil) do
    get("#{@prefix}/open-orders", params, config)
  end

  @doc """
  Cancel an order
  Bybit.Spot.Private.cancel_order(%{orderId: "1309923963809357056"})

  {:ok,
   %{
    "retCode" => 0,
    "retMsg" => "OK",
    "result" => {
        "orderId" => "1309923963809357056",
        "orderLinkId" => "CJM00314",
        "symbol" => "ETHUSDT",
        "status" => "NEW",
        "accountId" => "1107450",
        "createTime" => "1670891105091",
        "orderPrice" => "400",
        "orderQty" => "0.001",
        "execQty" => "0",
        "timeInForce" => "GTC",
        "orderType" => "LIMIT",
        "side" => "BUY",
        "orderCategory" => 0
    },
    "retExtInfo" => {},
    "time" => 1670891175641
  }}

  """
  def cancel_order(params, config \\ nil) do
    post("#{@prefix}/cancel-order", params, config)
  end

  @doc """
  Cancel all active orders
  Bybit.Spot.Private.cancel_all_orders(%{symbol: "ETHUSDT"})

  {:ok,
    %{
    "result" => %{"success" => "1"},
    "retCode" => 0,
    "retExtInfo" => %{},
    "retMsg" => "OK",
    "time" => 1670892621962
  }}
  """
  def cancel_all_orders(params, config \\ nil) do
    post("#{@prefix}/cancel-orders", params, config)
  end

  @doc """
  Get positions data

  Examples:

  Bybit.Spot.Private.get_account()

  {:ok,
  %{
    "result" => %{
      "balances" => [
        %{
          "coin" => "BTC",
          "coinId" => "BTC",
          "free" => "0.2",
          "locked" => "0",
          "total" => "0.2"
        },
        %{
          "coin" => "EOS",
          "coinId" => "EOS",
          "free" => "2000",
          "locked" => "0",
          "total" => "2000"
        },
        %{
          "coin" => "ETH",
          "coinId" => "ETH",
          "free" => "1.001",
          "locked" => "0",
          "total" => "1.001"
        },
        %{
          "coin" => "USDC",
          "coinId" => "USDC",
          "free" => "48000",
          "locked" => "0",
          "total" => "48000"
        },
        %{
          "coin" => "USDT",
          "coinId" => "USDT",
          "free" => "47999.68425",
          "locked" => "0",
          "total" => "47999.68425"
        },
        %{
          "coin" => "XRP",
          "coinId" => "XRP",
          "free" => "10000",
          "locked" => "0",
          "total" => "10000"
        }
      ]
    },
    "retCode" => 0,
    "retExtInfo" => %{},
    "retMsg" => "OK",
    "time" => 1670905559628
  }}
  """
  def get_account() do
    get("#{@prefix}/account")
  end

  @doc """
  Get positions data

  Examples:

  Bybit.Spot.Private.get_account()

  {:ok,
  %{
    "result" => %{
      "list" => [
        %{
          "creatTime" => "1670831195214",
          "execFee" => "0",
          "executionTime" => "1670831195226",
          "feeTokenId" => "ETH",
          "id" => "1309421403436492800",
          "isBuyer" => "0",
          "isMaker" => "1",
          "makerRebate" => "0",
          "matchOrderId" => "1309412011492255744",
          "orderId" => "1309421403277109248",
          "orderPrice" => "315.75",
          "orderQty" => "0.001",
          "symbol" => "ETHUSDT",
          "tradeId" => "2110000000001016835"
        }
      ]
    },
    "retCode" => 0,
    "retExtInfo" => %{},
    "retMsg" => "OK",
    "time" => 1670905760592
  }}
  """
  def get_my_trades(params, config \\ nil) do
    get("#{@prefix}/my-trades", params, config)
  end
end
