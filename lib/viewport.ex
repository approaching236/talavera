defmodule ViewPort do

  @spec neighborhood(HexGrid.Hex, depth :: integer) :: [HexGrid.Hex]
  def neighborhood(hex, 0), do: [hex]
  def neighborhood(hex, depth) do
  end
end
