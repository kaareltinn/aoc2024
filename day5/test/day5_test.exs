defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "part1/1" do
    input = Day5.parse_input("example.txt")
    assert Day5.part1(input) == 143
  end

  test "part2/1" do
    input = Day5.parse_input("example.txt")
    assert Day5.part2(input) == 123
  end

  test "sort_update/2" do
    input = Day5.parse_input("example.txt")
    assert Day5.sort_update([75,97,47,61,53], input.rules) == [97, 75, 47, 61, 53]
    assert Day5.sort_update([61,13,29], input.rules) == [61, 29, 13]
    assert Day5.sort_update([97,13,75,29,47], input.rules) == [97, 75, 47, 29, 13]
  end
end
