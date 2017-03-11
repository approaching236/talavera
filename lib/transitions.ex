defmodule Transitions do

  def simplify({r, n}) do
    if r == 0 do
      {0, 0}
    else
      {r, rem(n, ring_size(r))}
    end
  end

  def ring_size(n) do
    inspect(n)
    if n == 0 do
      1
    else
      6 * n
    end
  end

  def is_corner?({r, n}) do
    if r == 0 do
      true
    else
      rem(n, r) == 0
    end
  end

  def at({r, n}) do
    if r == 0 do
      (0..5) |> Enum.map(&({1, &1}))
    else
      inner_coordinates({r, n}) ++ sibling_coordinates({r, n}) ++ outer_coordinates({r, n})
      |> Enum.map(&simplify/1)
    end
  end

  def cardinal({r, n}) do
    {cardinal, _} = n / r
                    |> Float.to_string
                    |> Integer.parse

    cardinal
  end

  def inner_coordinates({r, n}) do
    cond do
      r == 0 ->
        []
      is_corner?({r, n}) ->
        [{r - 1, cardinal({r, n}) * (r - 1)}]
      true ->
        [{r - 1, n - cardinal({r, n}) - 1},
         {r - 1, n - cardinal({r, n})}]
    end
  end

  def sibling_coordinates({r, n}) do
    cond do
      r == 0 ->
        []
      true ->
        [{r, n - 1},
         {r, n + 1}]
    end
  end

  def outer_coordinates({r, n}) do
    cond do
      r == 0 ->
        IEx.Info.info (0..5) |> Enum.map(&({1, &1}))
      is_corner?({r, n}) ->
        [{r + 1, (cardinal({r, n}) * (r + 1)) - 1},
         {r + 1, (cardinal({r, n}) * (r + 1))},
         {r + 1, (cardinal({r, n}) * (r + 1)) + 1}]
      true ->
        [{r + 1, n + cardinal({r,n})},
         {r + 1, n + cardinal({r,n}) + 1}]
    end
  end
end
