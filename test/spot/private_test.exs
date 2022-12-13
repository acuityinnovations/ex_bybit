defmodule Bybit.Spot.PrivateTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start()
  end

  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end

  test "create an order" do
    use_cassette "spot/private/create_order" do
      {:ok,
       %{
         "retCode" => 0,
         "retMsg" => "OK",
         "result" => _
       }} =
        Bybit.Spot.Private.create_order(%{
          symbol: "ETHUSDT",
          orderQty: "0.001",
          side: "Buy",
          orderType: "LIMIT",
          timeInForce: "GTC",
          orderPrice: "292",
          orderLinkId: random_string(10)
        })
    end
  end

  test "get all open orders" do
    use_cassette "spot/private/get_open_orders" do
      Bybit.Spot.Private.cancel_all_orders(%{symbol: "ETHUSDT"})

      _ =
        Bybit.Spot.Private.create_order(%{
          symbol: "ETHUSDT",
          orderQty: "0.001",
          side: "Buy",
          orderType: "LIMIT",
          timeInForce: "GTC",
          orderPrice: "292",
          orderLinkId: random_string(10)
        })

      {:ok,
       %{
         "retCode" => 0,
         "retMsg" => "OK",
         "result" => %{
           "list" => _
         }
       }} = Bybit.Spot.Private.get_open_orders(%{symbol: "ETHUSDT"})

      Bybit.Spot.Private.cancel_all_orders(%{symbol: "ETHUSDT"})
    end
  end

  test "cancel an order" do
    use_cassette "spot/private/cancel_order" do
      {:ok,
       %{
         "retCode" => 0,
         "retMsg" => "OK",
         "result" => result
       }} =
        Bybit.Spot.Private.create_order(%{
          symbol: "ETHUSDT",
          orderQty: "0.001",
          side: "Buy",
          orderType: "LIMIT",
          timeInForce: "GTC",
          orderPrice: "292",
          orderLinkId: random_string(10)
        })

      {:ok,
       %{
         "retCode" => 0,
         "retMsg" => "OK",
         "result" => %{
           "symbol" => "ETHUSDT",
           "status" => "NEW",
           "orderPrice" => "292",
           "orderType" => "LIMIT",
           "side" => "BUY"
         }
       }} =
        Bybit.Spot.Private.cancel_order(%{
          orderId: result["orderId"]
        })
    end
  end

  test "cancel all open order" do
    use_cassette "spot/private/cancel_all_orders" do
      {:ok,
       %{
         "retCode" => 0,
         "retMsg" => "OK",
         "result" => _
       }} = Bybit.Spot.Private.cancel_all_orders(%{symbol: "ETHUSDT"})
    end
  end

  test "get account" do
    use_cassette "spot/private/get_account" do
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
         "retMsg" => "OK"
       }} = Bybit.Spot.Private.get_account()
    end
  end

  test "get my trades" do
    use_cassette "spot/private/get_my_trades" do
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
         "retMsg" => "OK"
       }} = Bybit.Spot.Private.get_my_trades(%{symbol: "ETHUSDT"})
    end
  end
end
