defmodule Bybit.Inverse.PublicTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start()
  end

  test "ping returns an empty map" do
    use_cassette "inverse/public/get_instruments" do
      {:ok,
       %{
         "ext_code" => "",
         "ext_info" => "",
         "result" => [
           %{
             "base_currency" => "BTC",
             "leverage_filter" => %{
               "leverage_step" => "0.01",
               "max_leverage" => 100,
               "min_leverage" => 1
             },
             "lot_size_filter" => %{
               "max_trading_qty" => 1_000_000,
               "min_trading_qty" => 1,
               "qty_step" => 1
             },
             "maker_fee" => "-0.00025",
             "name" => "BTCUSD",
             "price_filter" => %{
               "max_price" => "999999.5",
               "min_price" => "0.5",
               "tick_size" => "0.5"
             },
             "price_scale" => 2,
             "quote_currency" => "USD",
             "taker_fee" => "0.00075"
           }
           | _others
         ],
         "ret_code" => 0,
         "ret_msg" => "OK",
         "time_now" => "1603352676.323980"
       }} = Bybit.Inverse.Public.instruments()
    end
  end

  test "get mark price" do
    use_cassette "inverse/public/get_mark_price" do
      {:ok,
       %{
         "ext_code" => "",
         "ext_info" => "",
         "result" => [
           %{
             "ask_price" => "12745",
             "bid_price" => "12744.5",
             "countdown_hour" => 1,
             "funding_rate" => "0.0001",
             "high_price_24h" => "13250.00",
             "index_price" => "12740.91",
             "last_price" => "12744.50",
             "last_tick_direction" => "ZeroMinusTick",
             "low_price_24h" => "12127.00",
             "mark_price" => "12741.09",
             "next_funding_time" => "2020-10-22T08:00:00Z",
             "open_interest" => 479_998_596,
             "open_value" => "14616.80",
             "predicted_funding_rate" => "0.0001",
             "prev_price_1h" => "12835.00",
             "prev_price_24h" => "12197.50",
             "price_1h_pcnt" => "-0.007051",
             "price_24h_pcnt" => "0.044845",
             "symbol" => "BTCUSD",
             "total_turnover" => "47945832.15",
             "total_volume" => 426_115_011_948,
             "turnover_24h" => "196696.27",
             "volume_24h" => 2_499_111_540
           }
         ],
         "ret_code" => 0,
         "ret_msg" => "OK",
         "time_now" => "1603353138.269627"
       }} = Bybit.Inverse.Public.get_mark_price("BTCUSD")
    end
  end
end
