defmodule Talavera.TileController do
  use Talavera.Web, :controller

  def index(conn, params) do
    current = coordinate(params)

    conn
    |> assign(:current, current)
    |> assign(:transitions, Transitions.at(current))
    |> render("index.json")
  end

  def coordinate(params) do
    {r, _} = Integer.parse(params["r"])
    {n, _} = Integer.parse(params["n"])

    {r, n}
  end
end
