defmodule Bybit.Inverse.Public do
  @moduledoc false
  import Bybit.Api.Public

  @prefix "/v2/public"

  def server_time do
    get("#{@prefix}/time", %{})
  end

  def instruments do
    get("#{@prefix}/symbols", %{})
  end

  def get_mark_price(instrument) do
    get("#{@prefix}/tickers", %{symbol: instrument})
  end
end
