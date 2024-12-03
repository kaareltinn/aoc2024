defmodule Day2Part2Test do
  use ExUnit.Case
  doctest Day2Part2

  test "check/1" do
    assert Day2Part2.check([7, 6, 4, 2, 1]) == :safe
    assert Day2Part2.check([1, 2, 7, 8, 9]) == :unsafe
    assert Day2Part2.check([9, 7, 6, 2, 1]) == :unsafe
    assert Day2Part2.check([1, 3, 2, 4, 5]) == :safe
    assert Day2Part2.check([8, 6, 4, 4, 1]) == :safe
    assert Day2Part2.check([1, 3, 6, 7, 9]) == :safe
    assert Day2Part2.check([392, 394, 397, 398, 397]) == :safe
    assert Day2Part2.check([26, 27, 28, 31, 33, 34, 37, 37]) == :safe
    assert Day2Part2.check([375, 377, 372, 370, 369]) == :safe
    assert Day2Part2.check([1, 2, 3, 4, 3]) == :safe
    assert Day2Part2.check([1, 4, 3, 2, 1]) == :safe
    assert Day2Part2.check([1, 2, 3, 4, 5, 5]) == :safe
    assert Day2Part2.check([2, 2, 3, 4, 5]) == :safe
  end

  test "run/1" do
    input = Day2Part2.parse_input("./example_input.txt")
    assert Day2Part2.run(input) == 4
  end
end
