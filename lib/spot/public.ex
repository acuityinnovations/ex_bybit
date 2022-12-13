defmodule Bybit.Spot.Public do
  @moduledoc false
  import Bybit.Api.Public

  @prefix "/spot/v3/public"

  def server_time do
    get("#{@prefix}/server-time", %{})
  end

  def instruments do
    get("#{@prefix}/symbols", %{})
  end

  def get_mark_price(instrument) do
    get("#{@prefix}/quote/ticker/price", %{symbol: instrument})
  end
end
