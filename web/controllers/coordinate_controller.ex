defmodule Talavera.CoordinateController do
  use Talavera.Web, :controller

  alias Talavera.Coordinate

  def index(conn, _params) do
    coordinates = Repo.all(Coordinate)
    render(conn, "index.html", coordinates: coordinates)
  end

  def new(conn, _params) do
    changeset = Coordinate.changeset(%Coordinate{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"coordinate" => coordinate_params}) do
    changeset = Coordinate.changeset(%Coordinate{}, coordinate_params)

    case Repo.insert(changeset) do
      {:ok, _coordinate} ->
        conn
        |> put_flash(:info, "Coordinate created successfully.")
        |> redirect(to: coordinate_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    coordinate = Repo.get!(Coordinate, id)
    render(conn, "show.html", coordinate: coordinate)
  end

  def edit(conn, %{"id" => id}) do
    coordinate = Repo.get!(Coordinate, id)
    changeset = Coordinate.changeset(coordinate)
    render(conn, "edit.html", coordinate: coordinate, changeset: changeset)
  end

  def update(conn, %{"id" => id, "coordinate" => coordinate_params}) do
    coordinate = Repo.get!(Coordinate, id)
    changeset = Coordinate.changeset(coordinate, coordinate_params)

    case Repo.update(changeset) do
      {:ok, coordinate} ->
        conn
        |> put_flash(:info, "Coordinate updated successfully.")
        |> redirect(to: coordinate_path(conn, :show, coordinate))
      {:error, changeset} ->
        render(conn, "edit.html", coordinate: coordinate, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    coordinate = Repo.get!(Coordinate, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(coordinate)

    conn
    |> put_flash(:info, "Coordinate deleted successfully.")
    |> redirect(to: coordinate_path(conn, :index))
  end
end
