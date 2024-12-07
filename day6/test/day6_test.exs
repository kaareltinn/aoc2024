defmodule Day6Test do
  use ExUnit.Case
  doctest Day6


  #     ....#.....
  #     .........#
  #     ..........
  #     ..#.......
  #     .......#..
  #     ..........
  #     .#..^.....
  #     ........#.
  #     #.........
  #     ......#...
  test "part1/1" do
    input = Day6.parse_input("example.txt")
    state = Day6.init(input)
    assert Day6.part1(state) == 41
  end
end
