defmodule Bybit.Unified.Public do
  @moduledoc false
  import Bybit.Api.Public

  @prefix "/derivatives/v3/public"

  def server_time do
    get("/v3/public/time", %{})
  end
  def instruments do
    get("#{@prefix}/instruments-info", %{})
  end

  def get_mark_price(instrument) do
    get("#{@prefix}/tickers", %{symbol: instrument, category: "linear"})
  end
end
