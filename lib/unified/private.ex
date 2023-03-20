defmodule Bybit.Unified.Private do
  @moduledoc """
  Unified contract client.
  """

  import Bybit.Api.Private

  @type params :: map
  @type config :: map | nil
  @type response :: Bybit.Api.response()

  @prefix "/v5"

  @doc """
  Place a new order.

  ## Examples

  iex> Bybit.Unified.Private.create_order(%{
    "symbol": "BTCUSDT",
    "orderType": "Limit",
    "side": "Buy",
    "qty": "0.01",
    "price": "20002",
    "category": "linear"
  })
  {:ok,
   %{
    "retCode" => 0,
    "retMsg" => "OK",
    "result" => %{
        "orderId"=> "e10b0716-7c91-4091-b98a-1fa0f401c7d5",
        "orderLinkId"=> "test0000003"
    },
    "retExtInfo" => null,
    "time" => 1670891105099
  }}
  """
  def create_order(params, config \\ nil) do
    post("#{@prefix}/order/create", params, config)
  end

  @doc """
  Bybit.Unified.Private.get_open_orders(%{symbol: "ETHUSDT", "category": "linear"})

  {:ok,
   %{
    "retCode" => 0,
    "retMsg" => "OK",
    "result" => %{
        "nextPageCursor"=> "135ccc0d-8136-4e1b-8af3-07b11ee158d1%3A1665565610526%2C135ccc0d-8136-4e1b-8af3-07b11ee158d1%3A1665565610526",
        "category"=> "linear",
        "list"=> [
            {
                "symbol"=> "ETHUSDT",
                "orderType"=> "Limit",
                "orderLinkId"=> "test0000005",
                "orderId"=> "135ccc0d-8136-4e1b-8af3-07b11ee158d1",
                "stopOrderType"=> "UNKNOWN",
                "orderStatus"=> "New",
                "takeProfit"=> "",
                "cumExecValue"=> "0.00000000",
                "blockTradeId"=> "",
                "price"=> "700.00000000",
                "createdTime"=> 1665565610526,
                "tpTriggerBy"=> "UNKNOWN",
                "timeInForce"=> "GoodTillCancel",
                "basePrice"=> "",
                "updatedTime"=> 1665565610533,
                "side"=> "Buy",
                "triggerPrice"=> "",
                "cumExecFee"=> "0.00000000",
                "slTriggerBy"=> "UNKNOWN",
                "leavesQty"=> "0.1000",
                "closeOnTrigger"=> false,
                "cumExecQty"=> "0.00000000",
                "reduceOnly"=> false,
                "qty"=> "0.1000",
                "stopLoss"=> "",
                "triggerBy"=> "UNKNOWN",
                "orderIM"=> ""
            }
        ]
    },
    "retExtInfo" => {},
    "time" => 1670891962506
  }}
  """
  def get_open_orders(params, config \\ nil) do
    get("#{@prefix}/order/realtime", params, config)
  end

  @doc """
  Replace an order
  Bybit.Unified.Private.replace_order(%{orderId: "4c51a45f-7795-4b38-9b66-3c306b73f112", "symbol": "BTCUSDT", "category": "linear", "price": "35000"})

  {:ok,
   %{
    "retCode"=> 0,
    "retMsg"=> "OK",
    "result"=> %{
      "orderId"=> "42c86d66331e41998d12c2440ce90c1a",
      "orderLinkId"=> "e80d558e-ed"
    }
  }}

  """
  def replace_order(params, config \\ nil) do
    post("#{@prefix}/order/amend", params, config)
  end

  @doc """
  Cancel an order
  Bybit.Unified.Private.cancel_order(%{orderId: "4c51a45f-7795-4b38-9b66-3c306b73f112", "symbol": "BTCUSDT", "category": "linear"})

  {:ok,
   %{
    "retCode" => 0,
    "retMsg" => "OK",
    "result" => {
        "orderId"=> "42c86d66331e41998d12c2440ce90c1a",
        "orderLinkId"=> "e80d558e-ed"
    },
    "retExtInfo" => {},
    "time" => 1670891175641
  }}

  """
  def cancel_order(params, config \\ nil) do
    post("#{@prefix}/order/cancel", params, config)
  end

  @doc """
  Cancel all active orders
  Bybit.Unified.Private.cancel_all_orders(%{"category": "option"})

  {:ok,
    %{
    "retCode"=> 0,
    "retMsg"=> "OK",
    "result"=> {
    "list"=> [{
      "category"=> "option",
      "symbol"=> "BTC-24JUN22-45000-P",
      "orderId"=> "bd5f3b34-d64d-4b60-8188-438fbea4c552",
      "orderLinkId"=> "ac4e3b34-d64d-4b60-8188-438fbea4c552",
      }, {
      "category"=> "option",
      "symbol"=> "BTC-24JUN22-45000-P",
      "orderId"=> "4ddd727a-2af8-430e-a293-42895e594d18",
      "orderLinkId"=> "5cee727a-2af8-430e-a293-42895e594d18",
      }]
    },
    "retExtInfo"=> {
      "list"=> [{
        "code"=> 0,
        "msg"=> "OK"
      }, {
        "code"=> 0,
        "msg"=> "OK"
      }]
    },
    "time"=> 1657200736570
  }}
  """
  def cancel_all_orders(params, config \\ nil) do
    post("#{@prefix}/order/cancel-all", params, config)
  end

  @doc """
  Get positions data

  Examples:

  Bybit.Unified.Private.get_account()

  {:ok,
  %{
    "retCode"=> 0,
    "retMsg"=> "OK",
    "result"=> {
        "totalEquity"=> "445.20695266",
        "accountIMRate"=> "0.1195",
        "totalMarginBalance"=> "445.20695266",
        "totalInitialMargin"=> "53.20940585",
        "totalAvailableBalance"=> "391.99754682",
        "accountMMRate"=> "0.0129",
        "totalPerpUPL"=> "-13.12779308",
        "totalWalletBalance"=> "458.33474574",
        "totalMaintenanceMargin"=> "5.74823205",
        "coin"=> [
            {
                "currencyCoin"=> "USDC",
                "availableToBorrow"=> "1500000",
                "borrowSize"=> "0",
                "bonus"=> "",
                "accruedInterest"=> "0",
                "availableBalanceWithoutConvert"=> "500",
                "totalOrderIM"=> "0",
                "equity"=> "500",
                "totalPositionMM"=> "0",
                "usdValue"=> "500",
                "availableBalance"=> "391.99754682",
                "unrealisedPnl"=> "",
                "totalPositionIM"=> "0",
                "marginBalanceWithoutConvert"=> "500",
                "walletBalance"=> "500",
                "cumRealisedPnl"=> "",
                "marginBalance"=> "445.20695266"
            },
            {
                "currencyCoin"=> "USDT",
                "availableToBorrow"=> "2499945.20850984",
                "borrowSize"=> "54.79149016",
                "bonus"=> "",
                "accruedInterest"=> "0.0003021",
                "availableBalanceWithoutConvert"=> "-107.99938383",
                "totalOrderIM"=> "0",
                "equity"=> "-54.79149016",
                "totalPositionMM"=> "4.10432398",
                "usdValue"=> "-54.79304733",
                "availableBalance"=> "391.98640657",
                "unrealisedPnl"=> "-13.12741999",
                "totalPositionIM"=> "42.24959564",
                "marginBalanceWithoutConvert"=> "-54.79149016",
                "walletBalance"=> "-41.66407016",
                "cumRealisedPnl"=> "-41.66407016",
                "marginBalance"=> "445.19430024"
            }
        ]
    },
    "retExtInfo"=> {},
    "time"=> 1673266182240
  }}
  """
  def get_account() do
    get("#{@prefix}/account/wallet-balance")
  end

  @doc """
  Get positions data

  Examples:

  Bybit.Unified.Private.get_my_trades(%{symbol: "ETHUSDT", category: "linear"})

  {:ok,
  %{
    "retCode"=> 0,
    "retMsg"=> "OK",
    "result"=> {
        "nextPageCursor"=> "0%3A1657711949945%2C0%3A1657711949945",
        "category"=> "linear",
        "list"=> [
            {
                "symbol"=> "ETHUSDT",
                "leverage"=> "10",
                "updatedTime"=> 1657711949945,
                "side"=> "Buy",
                "positionValue"=> "536.92500000",
                "takeProfit"=> "",
                "tpslMode"=> "Full",
                "riskId"=> 11,
                "trailingStop"=> "",
                "entryPrice"=> "1073.85000000",
                "unrealisedPnl"=> "",
                "markPrice"=> "1080.65000000",
                "size"=> "0.5000",
                "positionStatus"=> "normal",
                "stopLoss"=> "",
                "cumRealisedPnl"=> "-0.32215500",
                "positionMM"=> "2.97456450",
                "createdTime"=> 1657711949928,
                "positionIdx"=> 0,
                "positionIM"=> "53.98243950"
            }
        ]
    },
    "time"=> 1657713693182
  }}
  """
  def get_my_trades(params, config \\ nil) do
    get("#{@prefix}/position/list", params, config)
  end
end
