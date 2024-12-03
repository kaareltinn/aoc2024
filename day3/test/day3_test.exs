defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "greets the world" do
    input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
    assert Day3.part1(input) == 161
  end
end
