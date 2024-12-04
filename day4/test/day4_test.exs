defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  test "part1/1" do
    input = Day4.parse_input("example.txt")

    assert Day4.part1(input) == 18
  end

  test "part2/1" do
    input = Day4.parse_input("example.txt")

    assert Day4.part2(input) == 9
  end
end
