defmodule Bybit.V5.Public do
  @moduledoc false
  import Bybit.Api.Public

  @prefix "/v5"

  def instruments do
    get("#{@prefix}/market/instruments-info", %{})
  end

  def get_mark_price(instrument) do
    get("#{@prefix}/market/tickers", %{symbol: instrument, category: "linear"})
  end
end
