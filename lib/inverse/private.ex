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
    qty: 10,
    order_type: "Limit",
    side: "Buy",
    time_in_force: "PostOnly",
    order_link_id: "1234a"
  })
  {:ok,
   %{
     "ext_code" => "",
     "ext_info" => "",
     "rate_limit" => 100,
     "rate_limit_reset_ms" => 1603351324707,
     "rate_limit_status" => 98,
     "result" => %{
       "created_at" => "2020-10-22T07:22:04.708Z",
       "cum_exec_fee" => 0,
       "cum_exec_qty" => 0,
       "cum_exec_value" => 0,
       "last_exec_price" => 0,
       "last_exec_time" => 0,
       "leaves_qty" => 10,
       "order_id" => "9fc29a28-50a4-497c-a9a3-17e7d9a54fa5",
       "order_link_id" => "",
       "order_status" => "Created",
       "order_type" => "Limit",
       "price" => 11000,
       "qty" => 10,
       "reject_reason" => "EC_NoError",
       "side" => "Buy",
       "symbol" => "BTCUSD",
       "time_in_force" => "PostOnly",
       "updated_at" => "2020-10-22T07:22:04.709Z",
       "user_id" => 1911583
     },
     "ret_code" => 0,
     "ret_msg" => "OK",
     "time_now" => "1603351324.709381"
   }}
  """
  @spec create_order(params, config) :: response
  def create_order(params, config \\ nil) do
    post("#{@prefix}/order/create", params, config)
  end

  @spec create_order_v1(params, config) :: response
  def create_order_v1(params, config \\ nil) do
    post("/open-api/order/create", params, config)
  end

  @doc """
  Bybit.Inverse.Private.get_open_orders(%{symbol: "BTCUSD", order_status: "New"})

  {:ok,
   %{
     "ext_code" => "",
     "ext_info" => nil,
     "rate_limit" => 600,
     "rate_limit_reset_ms" => 1603351409763,
     "rate_limit_status" => 599,
     "result" => %{
       "current_page" => 1,
       "data" => [
         %{
           "created_at" => "2020-10-22T07:22:04.000Z",
           "cum_exec_fee" => 0,
           "cum_exec_qty" => 0,
           "cum_exec_value" => 0,
           "ext_fields" => %{
             "o_req_num" => -2338387224617,
             "op_from" => "api",
             "remark" => "42.116.92.215",
             "xreq_type" => "x_create"
           },
           "last_exec_price" => 0,
           "last_exec_time" => "0.000000",
           "leaves_qty" => 10,
           "leaves_value" => 9.0909e-4,
           "order_id" => "9fc29a28-50a4-497c-a9a3-17e7d9a54fa5",
           "order_link_id" => "",
           "order_status" => "New",
           "order_type" => "Limit",
           "price" => 11000,
           "qty" => 10,
           "reject_reason" => "NoError",
           "side" => "Buy",
           "symbol" => "BTCUSD",
           "time_in_force" => "PostOnly",
           "updated_at" => "2020-10-22T07:22:04.000Z",
           "user_id" => 1911583
         }
       ],
       "last_page" => 1
     },
     "ret_code" => 0,
     "ret_msg" => "ok",
     "time_now" => "1603351409.756038"
   }}
  """
  def get_open_orders(params, config \\ nil) do
    get("/open-api/order/list", params, config)
  end

  def query_order(params, config \\ nil) do
    get("/v2/private/order", params, config)
  end

  @doc """
  Cancel an order
  Bybit.Inverse.Private.cancel_order(%{symbol: "BTCUSD", order_id: "9fc29a28-50a4-497c-a9a3-17e7d9a54fa5"})

  {:ok,
   %{
     "ext_code" => "",
     "ext_info" => "",
     "rate_limit" => 100,
     "rate_limit_reset_ms" => 1603351819995,
     "rate_limit_status" => 99,
     "result" => %{
       "created_at" => "2020-10-22T07:22:04.708Z",
       "cum_exec_fee" => 0,
       "cum_exec_qty" => 0,
       "cum_exec_value" => 0,
       "last_exec_price" => 0,
       "last_exec_time" => 0,
       "leaves_qty" => 10,
       "order_id" => "9fc29a28-50a4-497c-a9a3-17e7d9a54fa5",
       "order_link_id" => "",
       "order_status" => "New",
       "order_type" => "Limit",
       "price" => 11000,
       "qty" => 10,
       "reject_reason" => "EC_NoError",
       "side" => "Buy",
       "symbol" => "BTCUSD",
       "time_in_force" => "PostOnly",
       "updated_at" => "2020-10-22T07:30:19.996Z",
       "user_id" => 1911583
     },
     "ret_code" => 0,
     "ret_msg" => "OK",
     "time_now" => "1603351819.997138"
   }}

  """
  def cancel_order(params, config \\ nil) do
    post("#{@prefix}/order/cancel", params, config)
  end

  def cancel_order_v1(params, config \\ nil) do
    post("/open-api/order/cancel", params, config)
  end

  @doc """
  amend an order
  Bybit.Inverse.Private.replace_order(%{symbol: "BTCUSD", order_id: "1c5dc1aa-729f-4b34-93e4-23f6a2f6da78", p_r_qty: 99})

  {:ok,
   %{
     "ext_code" => "",
     "ext_info" => nil,
     "rate_limit" => 100,
     "rate_limit_reset_ms" => 1603352020886,
     "rate_limit_status" => 99,
     "result" => %{"order_id" => "def1f12d-3fff-4205-888c-1136b68fbc9c"},
     "ret_code" => 0,
     "ret_msg" => "ok",
     "time_now" => "1603352020.875887"
   }}
  """
  def replace_order(params, config \\ nil) do
    post("#{@prefix}/order/replace", params, config)
  end

  @doc """
  Cancel all active orders
  Bybit.Inverse.Private.cancel_all_orders(%{symbol: "BTCUSD"})

  {:ok,
   %{
     "ext_code" => "",
     "ext_info" => "",
     "rate_limit" => 100,
     "rate_limit_reset_ms" => 1603352049755,
     "rate_limit_status" => 89,
     "result" => [
       %{
         "cancel_type" => "CancelByUser",
         "clOrdID" => "def1f12d-3fff-4205-888c-1136b68fbc9c",
         "create_type" => "CreateByUser",
         "created_at" => "2020-10-22T07:31:32.711031Z",
         "cross_seq" => 2204096451,
         "cross_status" => "PendingCancel",
         "leaves_qty" => 11,
         "leaves_value" => "0",
         "order_link_id" => "1234a",
         "order_status" => "",
         "order_type" => "Limit",
         "price" => "11000",
         "qty" => 11,
         "side" => "Buy",
         "symbol" => "BTCUSD",
         "time_in_force" => "PostOnly",
         "updated_at" => "2020-10-22T07:34:09.756075Z",
         "user_id" => 1911583
       }
     ],
     "ret_code" => 0,
     "ret_msg" => "OK",
     "time_now" => "1603352049.756377"
   }}
  """
  def cancel_all_orders(params, config \\ nil) do
    post("#{@prefix}/order/cancelAll", params, config)
  end

  @doc """
  Get wallet balance

  Examples:

  - Get wallet balance of a coin:
    Bybit.Inverse.Private.get_account(%{coin: "BTC"}, config)

  - Get wallet balance of every coins:
    Bybit.Inverse.Private.get_account(%{}, config)

  {:ok,
   %{
    "ext_code" => "",
    "ext_info" => "",
    "rate_limit" => 120,
    "rate_limit_reset_ms" => 1616145759482,
    "rate_limit_status" => 119,
    "result" => %{
      "BTC" => %{
        "available_balance" => 0.00485977,
        "cum_realised_pnl" => -5.2033e-4,
        "equity" => 0.0048741,
        "given_cash" => 0,
        "occ_closing_fee" => 4.3e-6,
        "occ_funding_fee" => 0,
        "order_margin" => 0,
        "position_margin" => 0.00486471,
        "realised_pnl" => -6.6e-7,
        "service_cash" => 0,
        "unrealised_pnl" => 5.09e-6,
        "used_margin" => 9.24e-6,
        "wallet_balance" => 0.00486901
      },
      "ETH" => %{
        "available_balance" => 0,
        "cum_realised_pnl" => 0,
        "equity" => 0,
        "given_cash" => 0,
        "occ_closing_fee" => 0,
        "occ_funding_fee" => 0,
        "order_margin" => 0,
        "position_margin" => 0,
        "realised_pnl" => 0,
        "service_cash" => 0,
        "unrealised_pnl" => 0,
        "used_margin" => 0,
        "wallet_balance" => 0
      }
    }
  }
  """
  def get_account(params, config \\ nil) do
    get("#{@prefix}/wallet/balance", params, config)
  end

  @doc """
  Get positions data

  Examples:

  - Get positions of a symbol:
    Bybit.Inverse.Private.get_position(%{symbol: "BTCUSD"}, config)

  - Get positions of every symbols:
    Bybit.Inverse.Private.get_account(%{}, config)

  {:ok,
   %{
     "ext_code" => "",
     "ext_info" => "",
     "rate_limit" => 120,
     "rate_limit_reset_ms" => 1616147246834,
     "rate_limit_status" => 118,
     "result" => [
        %{
          "data" => %{
          "bust_price" => "53235.5",
          "auto_add_margin" => 0,
          "side" => "Buy",
          "effective_leverage" => "10",
          "is_isolated" => true,
          "occ_closing_fee" => "0.00000029",
          "entry_price" => "58558.29478246",
          "position_status" => "Normal",
          "cross_seq" => 444081383,
          "id" => 0,
          "take_profit" => "0",
          "unrealised_pnl" => -1.02e-6,
          "user_id" => 1946832,
          "position_margin" => "0.00003444",
          "position_idx" => 0,
          "cum_realised_pnl" => "-0.00051731",
          "liq_price" => "53479",
          "created_at" => "2020-10-26T06:27:41Z",
          "position_seq" = 287141589,
          "deleverage_indicator" => 2,
          "occ_funding_fee" => "0",
          "trailing_stop" => "0",
          "risk_id" => 1,
          "symbol" => "BTCUSD",
          "wallet_balance" => "0.00487203",
          "oc_calc_data" => "{\"blq\":2,\"blv\":\"0.0002941\",\"slq\":0,\"bmp\":6800.408,\"smp\":0,\"fq\":-5,\"fc\":-0.00029477,\"bv2c\":1.00225,\"sv2c\":1.0007575}",
          "stop_loss" => "0",
          "leverage" => "10",
          "position_value" => "0.00034154",
          "size" => 20,
          "order_margin" => "0",
          "mode" => 0,
          "realised_pnl" => "0.00000236",
          "updated_at" => "2021-03-19T09:39:26.749076173Z"
          },
          "is_valid" => true
        }
      ]
    }
  """
  def get_position(params, config \\ nil) do
    get("#{@prefix}/position/list", params, config)
  end
end
