defmodule ViewportTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, viewport} = Viewport.start_link
    {:ok, hex} = HexGrid.Hex.new(0, 0, 0)
    {:ok, viewport: viewport, hex: hex}
  end

  test "stores values by key", %{viewport: viewport, hex: hex} do
    assert Viewport.get(viewport, hex) == nil

    Viewport.put(viewport, hex, 3)
    assert Viewport.get(viewport, hex) == 3
  end
end
