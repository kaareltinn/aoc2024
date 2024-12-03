defmodule Day2Part1Test do
  use ExUnit.Case
  doctest Day2Part1

  test "check/1" do
    assert Day2Part1.check([7, 6, 4, 2, 1]) == :safe
    assert Day2Part1.check([1, 3, 6, 7, 9]) == :safe
    assert Day2Part1.check([1, 2, 7, 8, 9]) == :unsafe
    assert Day2Part1.check([9, 7, 6, 2, 1]) == :unsafe
    assert Day2Part1.check([1, 3, 2, 4, 5]) == :unsafe
    assert Day2Part1.check([8, 6, 4, 4, 1]) == :unsafe
  end

  test "run/1" do
    input = Day2Part1.parse_input("./example_input.txt")
    assert Day2Part1.run(input) == 2
  end
end
