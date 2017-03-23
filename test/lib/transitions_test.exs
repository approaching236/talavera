defmodule TransitionsTest do
  use ExUnit.Case

  describe "ring_size/1" do
    test "0" do
      assert Transitions.ring_size(0) == 1
    end
    test "1" do
      assert Transitions.ring_size(1) == 6
    end
    test "2" do
      assert Transitions.ring_size(2) == 12
    end
    test "3" do
      assert Transitions.ring_size(3) == 18
    end
    test "4" do
      assert Transitions.ring_size(4) == 24
    end
  end

  describe "is_corner?/1" do
    test "{0,0}" do
      assert Transitions.is_corner?({0,0})
    end

    test "{1,1}" do
      assert Transitions.is_corner?({1,1})
    end
    test "{1,2}" do
      assert Transitions.is_corner?({1,2})
    end
    test "{1,3}" do
      assert Transitions.is_corner?({3,0})
    end

    test "{2,1}" do
      assert Transitions.is_corner?({3,0})
    end
    test "{2,7}" do
      refute Transitions.is_corner?({2,7})
    end

    test "{3,0}" do
      assert Transitions.is_corner?({3,0})
    end
    test "{3,2}" do
      refute Transitions.is_corner?({3,2})
    end
    test "{3,7}" do
      refute Transitions.is_corner?({3,7})
    end
    test "{3,9}" do
      assert Transitions.is_corner?({3,9})
    end

    test "{4,16}" do
      assert Transitions.is_corner?({4,16})
    end
  end

  describe "simplify/1" do
    test "{1, 6}" do
      assert Transitions.simplify({1, 6}) == {1, 0}
    end
  end

  describe "transitions/2" do
    test "{0,0}" do
      assert Transitions.at({0,0}) == [{1,0}, {1,1},
                                       {1,2}, {1,3},
                                       {1,4}, {1,5}]
    end
    test "{1,5}" do
      assert Transitions.at({1,5}) == [{0,0},
                                       {1,4}, {1,0},
                                       {2,9}, {2,10}, {2,11}]
    end
    test "{2,7}" do
      assert Transitions.at({2,7}) == [{1,3}, {1,4},
                                       {2,6}, {2,8},
                                       {3,10}, {3,11}]
    end
    test "{2,11}" do
      assert Transitions.at({2,11}) == [{1,5}, {1,0},
                                       {2,10}, {2,0},
                                       {3,16}, {3,17}]
    end
    test "{3,7}" do
      assert Transitions.at({3,7}) == [{2,4}, {2,5},
                                       {3,6}, {3,8},
                                       {4,9}, {4,10}]
    end
    test "{4,12}" do
      assert Transitions.at({4,12}) == [{3,9},
                                        {4,11}, {4,13},
                                        {5, 14}, {5, 15}, {5, 16}]
    end

    test "transitions are reflexive" do
      for r <- (0..10) do
        for n <- (0..(Transitions.ring_size(r) - 1)) do
          assert Enum.all?(Transitions.at({r, n}), &({r, n} in Transitions.at(&1)))
        end
      end
    end
  end
end
