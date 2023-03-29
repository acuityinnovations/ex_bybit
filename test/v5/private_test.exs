defmodule Bybit.V5.PrivateTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start()
  end

  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end

  test "create an order" do
    use_cassette "v5/private/create_order" do
      {:ok,
       %{
         "retCode" => 0,
         "retMsg" => "OK",
         "result" => _
       }} =
        Bybit.V5.Private.create_order(%{
          symbol: "BTCUSDT",
          orderType: "Limit",
          side: "Buy",
          qty: "0.01",
          price: "17000",
          timeInForce: "GTC",
          category: "linear"
        })
    end
  end

  test "replace an order" do
    use_cassette "v5/private/replace_order" do
      {:ok,
       %{
         "retCode" => 0,
         "retMsg" => "OK",
         "result" => %{
           "orderId" => order_id,
           "orderLinkId" => _order_link_id
         }
       }} =
        Bybit.V5.Private.create_order(%{
          symbol: "BTCUSDT",
          orderType: "Limit",
          side: "Buy",
          qty: "0.01",
          price: "17000",
          timeInForce: "GTC",
          category: "linear"
        })

      {:ok,
       %{
         "retCode" => 0,
         "retMsg" => "OK",
         "result" => _
       }} =
        Bybit.V5.Private.replace_order(%{
          orderId: order_id,
          symbol: "BTCUSDT",
          price: "17001",
          category: "linear"
        })
    end
  end

  test "get all open orders" do
    use_cassette "v5/private/get_open_orders" do
      Bybit.V5.Private.cancel_all_orders(%{symbol: "BTCUSDT", category: "linear"})

      _ =
        Bybit.V5.Private.create_order(%{
          symbol: "BTCUSDT",
          orderType: "Limit",
          side: "Buy",
          qty: "0.01",
          price: "17000",
          timeInForce: "GoodTillCancel",
          category: "linear"
        })

      {:ok,
       %{
         "retCode" => 0,
         "retMsg" => "OK",
         "result" => %{
           "category" => "linear",
           "list" => _
         }
       }} = Bybit.V5.Private.get_open_orders(%{category: "linear", settleCoin: "linear"})

      # Bybit.v5.Private.cancel_all_orders(%{symbol: "BTCUSDT", category: "linear"})
    end
  end

  test "cancel an order" do
    use_cassette "v5/private/cancel_order" do
      {:ok,
       %{
         "retCode" => 0,
         "retMsg" => "OK",
         "result" => result
       }} =
        Bybit.V5.Private.create_order(%{
          symbol: "BTCUSDT",
          orderType: "Limit",
          side: "Buy",
          qty: "0.01",
          price: "17000",
          timeInForce: "GTC",
          category: "linear"
        })

      {:ok,
       %{
         "retCode" => 0,
         "retMsg" => "OK",
         "result" => _
       }} =
        Bybit.V5.Private.cancel_order(%{
          orderId: result["orderId"],
          symbol: "BTCUSDT",
          category: "linear"
        })
    end
  end

  test "cancel all open order" do
    use_cassette "v5/private/cancel_all_orders" do
      _ =
        Bybit.V5.Private.create_order(%{
          symbol: "BTCUSDT",
          orderType: "Limit",
          side: "Buy",
          qty: "0.01",
          price: "17000",
          timeInForce: "GoodTillCancel",
          category: "linear"
        })

      {:ok,
       %{
         "retCode" => 0,
         "retMsg" => "OK",
         "result" => _
       }} = Bybit.V5.Private.cancel_all_orders(%{category: "linear", symbol: "BTCUSDT"})
    end
  end

  test "get account" do
    use_cassette "v5/private/get_account" do
      {:ok,
       %{
         "retCode" => 0,
         "retMsg" => "OK",
         "result" => _
       }} =
        Bybit.V5.Private.get_account(%{
          accountType: "UNIFIED"
        })
    end
  end

  test "get my trades" do
    use_cassette "v5/private/get_my_trades" do
      {:ok,
       %{
         "result" => %{
           "list" => _
         },
         "retCode" => 0,
         "retExtInfo" => %{},
         "retMsg" => "OK"
       }} = Bybit.V5.Private.get_my_trades(%{symbol: "ETHUSDT", category: "linear"})
    end
  end
end
