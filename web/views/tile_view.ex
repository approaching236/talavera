defmodule Talavera.TileView do
  use Talavera.Web, :view

  def tile(conn)
    %{
      current: conn.# get coordinates from connection
      neighbors: Enum.map(transitions, &tile_json/1)
    }
  end

  def tile_json({r, n}) do
    %{
      bullshit: true,
      position: [r, n]
    }
  end
end
