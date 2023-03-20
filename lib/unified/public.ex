defmodule Bybit.Unified.Public do
  @moduledoc false
  import Bybit.Api.Public

  @prefix "/v5"

  def instruments do
    get("#{@prefix}/instruments-info", %{})
  end

  def get_mark_price(instrument) do
    get("#{@prefix}/tickers", %{symbol: instrument, category: "linear"})
  end
end
