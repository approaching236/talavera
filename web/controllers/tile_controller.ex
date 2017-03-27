defmodule Talavera.TileController do
  use Talavera.Web, :controller

  def index(conn, _params) do
    current = {2, 7}
    transitions = Transitions.at(current)

    render conn, "index.json", current: current,
                               transitions: transitions
  end
end
