defmodule Talavera.Router do
  use Talavera.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Talavera do
    pipe_through :browser # Use the default browser stack

    get "/tile/:r/:n", TileController, :index
    get "/", PageController, :index

    resources "/coordinates", CoordinateController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Talavera do
  #   pipe_through :api
  # end
end
