defmodule Bybit.Inverse.PrivateTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start()
  end

  test "create an order" do
    use_cassette "inverse/private/create_order" do
      {:ok,
       %{
         "ext_code" => "",
         "ext_info" => "",
         "rate_limit" => 100,
         "rate_limit_reset_ms" => 1_603_354_326_603,
         "rate_limit_status" => 99,
         "result" => %{
           "created_at" => "2020-10-22T08:12:06.604Z",
           "cum_exec_fee" => 0,
           "cum_exec_qty" => 0,
           "cum_exec_value" => 0,
           "last_exec_price" => 0,
           "last_exec_time" => 0,
           "leaves_qty" => 10,
           "order_id" => "5fccde91-e705-495c-bcca-450965a24851",
           "order_link_id" => "",
           "order_status" => "Created",
           "order_type" => "Limit",
           "price" => 11000,
           "qty" => 10,
           "reject_reason" => "EC_NoError",
           "side" => "Buy",
           "symbol" => "BTCUSD",
           "time_in_force" => "PostOnly",
           "updated_at" => "2020-10-22T08:12:06.604Z",
           "user_id" => 1_911_583
         },
         "ret_code" => 0,
         "ret_msg" => "OK",
         "time_now" => "1603354326.605082"
       }} =
        Bybit.Inverse.Private.create_order(%{
          symbol: "BTCUSD",
          price: "11000",
          qty: 10,
          order_type: "Limit",
          side: "Buy",
          time_in_force: "PostOnly"
        })
    end
  end

  test "amend an order" do
    use_cassette "inverse/private/replace_order" do
      {:ok,
       %{
         "ext_code" => "",
         "ext_info" => "",
         "rate_limit" => 100,
         "rate_limit_reset_ms" => 1_608_044_504_237,
         "rate_limit_status" => 99,
         "result" => %{"order_id" => "1c5dc1aa-729f-4b34-93e4-23f6a2f6da78"},
         "ret_code" => 0,
         "ret_msg" => "OK",
         "time_now" => "1608044504.238969"
       }} =
        Bybit.Inverse.Private.replace_order(%{
          symbol: "BTCUSD",
          order_id: "1c5dc1aa-729f-4b34-93e4-23f6a2f6da78",
          p_r_qty: 99
        })
    end
  end

  test "get all open orders" do
    use_cassette "inverse/private/get_open_orders" do
      {:ok,
       %{
         "ext_code" => "",
         "ext_info" => nil,
         "rate_limit" => 600,
         "rate_limit_reset_ms" => 1_603_355_521_310,
         "rate_limit_status" => 599,
         "result" => %{
           "current_page" => 1,
           "data" => [
             %{
               "created_at" => "2020-10-22T08:30:17.000Z",
               "cum_exec_fee" => 0,
               "cum_exec_qty" => 0,
               "cum_exec_value" => 0,
               "ext_fields" => %{
                 "o_req_num" => -2_353_754_924_617,
                 "op_from" => "api",
                 "remark" => "42.116.92.215",
                 "xreq_type" => "x_create"
               },
               "last_exec_price" => 0,
               "last_exec_time" => "0.000000",
               "leaves_qty" => 10,
               "leaves_value" => 9.0909e-4,
               "order_id" => "45739859-072f-47f5-8925-45f35d5ff781",
               "order_link_id" => "",
               "order_status" => "New",
               "order_type" => "Limit",
               "price" => 11000,
               "qty" => 10,
               "reject_reason" => "NoError",
               "side" => "Buy",
               "symbol" => "BTCUSD",
               "time_in_force" => "PostOnly",
               "updated_at" => "2020-10-22T08:30:17.000Z",
               "user_id" => 1_911_583
             }
           ],
           "last_page" => 1
         },
         "ret_code" => 0,
         "ret_msg" => "ok",
         "time_now" => "1603355521.303800"
       }} = Bybit.Inverse.Private.get_open_orders(%{symbol: "BTCUSD", order_status: "New"})
    end
  end

  test "cancel an order" do
    use_cassette "inverse/private/cancel_order" do
      {:ok,
       %{
         "ext_code" => "",
         "ext_info" => "",
         "rate_limit" => 100,
         "rate_limit_reset_ms" => 1_603_355_886_563,
         "rate_limit_status" => 99,
         "result" => %{
           "created_at" => "2020-10-22T08:30:17.366Z",
           "cum_exec_fee" => 0,
           "cum_exec_qty" => 0,
           "cum_exec_value" => 0,
           "last_exec_price" => 0,
           "last_exec_time" => 0,
           "leaves_qty" => 11,
           "order_id" => "45739859-072f-47f5-8925-45f35d5ff781",
           "order_link_id" => "",
           "order_status" => "New",
           "order_type" => "Limit",
           "price" => 11000,
           "qty" => 11,
           "reject_reason" => "EC_NoError",
           "side" => "Buy",
           "symbol" => "BTCUSD",
           "time_in_force" => "PostOnly",
           "updated_at" => "2020-10-22T08:38:06.564Z",
           "user_id" => 1_911_583
         },
         "ret_code" => 0,
         "ret_msg" => "OK",
         "time_now" => "1603355886.564473"
       }} =
        Bybit.Inverse.Private.cancel_order(%{
          symbol: "BTCUSD",
          order_id: "45739859-072f-47f5-8925-45f35d5ff781"
        })
    end
  end

  test "cancel all open order" do
    use_cassette "inverse/private/cancel_all_order" do
      {:ok,
       %{
         "ext_code" => "",
         "ext_info" => "",
         "rate_limit" => 100,
         "rate_limit_reset_ms" => 1_603_356_062_725,
         "rate_limit_status" => 89,
         "result" => [
           %{
             "cancel_type" => "CancelByUser",
             "clOrdID" => "614e039c-7ade-4b75-9a48-a1c51e13e2cc",
             "create_type" => "CreateByUser",
             "created_at" => "2020-10-22T08:40:41.271516Z",
             "cross_seq" => 2_204_391_499,
             "cross_status" => "PendingCancel",
             "leaves_qty" => 10,
             "leaves_value" => "0",
             "order_status" => "",
             "order_type" => "Limit",
             "price" => "11000",
             "qty" => 10,
             "side" => "Buy",
             "symbol" => "BTCUSD",
             "time_in_force" => "PostOnly",
             "updated_at" => "2020-10-22T08:41:02.726449Z",
             "user_id" => 1_911_583
           }
         ],
         "ret_code" => 0,
         "ret_msg" => "OK",
         "time_now" => "1603356062.726824"
       }} = Bybit.Inverse.Private.cancel_all_orders(%{symbol: "BTCUSD"})
    end
  end
end
