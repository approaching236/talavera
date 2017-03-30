defmodule Talavera.CoordinateControllerTest do
  use Talavera.ConnCase

  alias Talavera.Coordinate
  @valid_attrs %{q: 42, r: 42, s: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, coordinate_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing coordinates"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, coordinate_path(conn, :new)
    assert html_response(conn, 200) =~ "New coordinate"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, coordinate_path(conn, :create), coordinate: @valid_attrs
    assert redirected_to(conn) == coordinate_path(conn, :index)
    assert Repo.get_by(Coordinate, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, coordinate_path(conn, :create), coordinate: @invalid_attrs
    assert html_response(conn, 200) =~ "New coordinate"
  end

  test "shows chosen resource", %{conn: conn} do
    coordinate = Repo.insert! %Coordinate{}
    conn = get conn, coordinate_path(conn, :show, coordinate)
    assert html_response(conn, 200) =~ "Show coordinate"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, coordinate_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    coordinate = Repo.insert! %Coordinate{}
    conn = get conn, coordinate_path(conn, :edit, coordinate)
    assert html_response(conn, 200) =~ "Edit coordinate"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    coordinate = Repo.insert! %Coordinate{}
    conn = put conn, coordinate_path(conn, :update, coordinate), coordinate: @valid_attrs
    assert redirected_to(conn) == coordinate_path(conn, :show, coordinate)
    assert Repo.get_by(Coordinate, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    coordinate = Repo.insert! %Coordinate{}
    conn = put conn, coordinate_path(conn, :update, coordinate), coordinate: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit coordinate"
  end

  test "deletes chosen resource", %{conn: conn} do
    coordinate = Repo.insert! %Coordinate{}
    conn = delete conn, coordinate_path(conn, :delete, coordinate)
    assert redirected_to(conn) == coordinate_path(conn, :index)
    refute Repo.get(Coordinate, coordinate.id)
  end
end
