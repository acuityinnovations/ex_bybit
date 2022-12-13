defmodule Bybit.Spot.PublicTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start()
  end

  test "ping returns an empty map" do
    use_cassette "spot/public/instruments" do
      {:ok,
       %{
         "result" => %{
           "list" => [
             %{
               "alias" => "BTCUSDT",
               "baseCoin" => "BTC",
               "basePrecision" => "0.000001",
               "category" => "1",
               "innovation" => "0",
               "maxTradeAmt" => "100000",
               "maxTradeQty" => "63.01197227",
               "minPricePrecision" => "0.01",
               "minTradeAmt" => "1",
               "minTradeQty" => "0.00004",
               "name" => "BTCUSDT",
               "quoteCoin" => "USDT",
               "quotePrecision" => "0.00000001",
               "showStatus" => "1"
             },
             %{
               "alias" => "ETHUSDT",
               "baseCoin" => "ETH",
               "basePrecision" => "0.00001",
               "category" => "1",
               "innovation" => "0",
               "maxTradeAmt" => "100000000",
               "maxTradeQty" => "100000000",
               "minPricePrecision" => "0.01",
               "minTradeAmt" => "1",
               "minTradeQty" => "0.0005",
               "name" => "ETHUSDT",
               "quoteCoin" => "USDT",
               "quotePrecision" => "0.0000001",
               "showStatus" => "1"
             }
             | _
           ]
         }
       }} = Bybit.Spot.Public.instruments()
    end
  end

  test "get mark price" do
    use_cassette "spot/public/get_mark_price" do
      {:ok,
       %{
         "result" => %{"price" => "16929", "symbol" => "BTCUSDT"},
         "retCode" => 0,
         "retExtInfo" => %{},
         "retMsg" => "OK"
       }} = Bybit.Spot.Public.get_mark_price("BTCUSDT")
    end
  end
end
