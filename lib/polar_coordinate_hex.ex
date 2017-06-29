defmodule Transitions do

  def at({r, _n}) when r == 0 do
    (0..5) |> Enum.map(&({1, &1}))
  end
  def at({r, n}) do
    inner_coordinates({r, n}) ++ sibling_coordinates({r, n}) ++ outer_coordinates({r, n})
    |> Enum.map(&simplify/1)
  end

  def simplify({r, _n}) when r == 0, do: {0, 0}
  def simplify({r,  n})  when n < 0, do: simplify({r, n + ring_size(r)})
  def simplify({r,  n}),             do: {r, rem(n, ring_size(r))}

  def ring_size(n) when n == 0 do 1 end
  def ring_size(n) do 6 * n end

  def is_corner?({r, n}) do
    if r == 0 do
      true
    else
      rem(n, r) == 0
    end
  end

  def cardinal({r, n}) do div(n, r) end

  def inner_coordinates({r, n}) do
    cond do
      is_corner?({r, n}) ->
        [{r - 1, cardinal({r, n}) * (r - 1)}]
      true ->
        [{r - 1, n - cardinal({r, n}) - 1},
         {r - 1, n - cardinal({r, n})}]
    end
  end

  def sibling_coordinates({r, n}) do
    [{r, n - 1},
     {r, n + 1}]
  end

  def outer_coordinates({r, n}) do
    cond do
      is_corner?({r, n}) ->
        [{r + 1, (cardinal({r, n}) * (r + 1)) - 1},
         {r + 1, (cardinal({r, n}) * (r + 1))},
         {r + 1, (cardinal({r, n}) * (r + 1)) + 1}]
    true ->
      [{r + 1, n + cardinal({r,n})},
       {r + 1, n + cardinal({r,n}) + 1}]
    end
  end

  def area_of_circle(r) do
    Enum.reduce((0..r), 0, &(Transitions.ring_size(&1) + &2))
  end
end
