defmodule Talavera.TileView do
  use Talavera.Web, :view

  def render("index.json", %{current: current, transitions: transitions}) do
    %{current: render_one(current, Talavera.TileView, "tile.json"),
      neighbors: render_many(transitions, Talavera.TileView, "tile.json")}
  end

  def render("tile.json", %{tile: {r, n}}) do
    %{r: r,
      n: n}
  end
end
