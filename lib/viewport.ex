alias HexGrid.Map, as: HexMap
alias HexGrid.Hex, as: Hex

defmodule Viewport do
  def start_link do
    {:ok, hexmap} = HexMap.new_hex(1)
    Agent.start_link(fn -> hexmap end)
  end

  def get(hexmap, hex) do
    {:ok, value} = Agent.get(hexmap, &HexMap.get(&1, hex, :key))
    value
  end

  def update_hexmap(hexmap, hex, value) do
    {:ok, hexmap} = HexMap.set(hexmap, hex, :key, value)
    hexmap
  end

  def put(hexmap, hex, value) do
    Agent.update(hexmap, &update_hexmap(&1, hex, value))
  end
end
