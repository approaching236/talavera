defmodule ViewportRegistryTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, registry} = ViewportRegistry.start_link
    {:ok, hex} = HexGrid.Hex.new(0,0,0)
    {:ok, registry: registry, hex: hex}
  end

  test "spawns viewports", %{registry: registry, hex: hex} do
    assert ViewportRegistry.lookup(registry, "xibalba") == :error

    ViewportRegistry.create(registry, "xibalba")
    assert {:ok, viewport} = ViewportRegistry.lookup(registry, "xibalba")

    Viewport.put(viewport, hex, 1)
    assert Viewport.get(viewport, hex) == 1
  end

  test "removes buckets on exit", %{registry: registry, hex: hex} do
    ViewportRegistry.create(registry, "xibalba")
    {:ok, viewport} = ViewportRegistry.lookup(registry, "xibalba")
    Agent.stop(viewport)
    assert ViewportRegistry.lookup(registry, "xibalba") == :error
  end
end
