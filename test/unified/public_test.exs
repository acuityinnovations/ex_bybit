defmodule Bybit.Spot.PublicTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start()
  end

  test "ping returns an empty map" do
    use_cassette "unified/public/instruments-info" do
      {:ok,
       %{
         "result" => %{
           "list" => _
         }
       }} = Bybit.Unified.Public.instruments()
    end
  end

  test "get mark price" do
    use_cassette "unified/public/get_mark_price" do
      {:ok,
       %{
         "result" => %{
          "category"=>"linear",
          "list"=> _
         },
         "retCode" => 0,
         "retMsg" => "OK"
       }} = Bybit.Unified.Public.get_mark_price("BTCUSDT")
    end
  end
end
