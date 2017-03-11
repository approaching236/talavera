defmodule Talavera.PageController do
  use Talavera.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
