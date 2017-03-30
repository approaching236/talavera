defmodule Talavera.Coordinate do
  use Talavera.Web, :model

  schema "coordinates" do
    field :q, :integer
    field :r, :integer
    field :s, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:q, :r, :s])
    |> validate_required([:q, :r, :s])
  end
end
