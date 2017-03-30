defmodule Talavera.CoordinateTest do
  use Talavera.ModelCase

  alias Talavera.Coordinate

  @valid_attrs %{q: 42, r: 42, s: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Coordinate.changeset(%Coordinate{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Coordinate.changeset(%Coordinate{}, @invalid_attrs)
    refute changeset.valid?
  end
end
