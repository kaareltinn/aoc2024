defmodule Day3 do
  def parse_input(filename) do
    File.read!(filename)
  end

  def part1(input) do
    Regex.scan(~r/mul\((\d+),(\d+)\)/, input)
    |> Enum.map(fn [_, a, b] -> String.to_integer(a) * String.to_integer(b) end)
    |> Enum.sum()
  end

  def part2(input) do
    Regex.scan(~r/mul\((\d+),(\d+)\)|do\(\)|don't\(\)/, input)
    |> Enum.reduce({0, :do}, fn
      [_, a, b], {acc, :do}  -> {acc + String.to_integer(a) * String.to_integer(b), :do}
      [_, _a, _b], {acc, :dont} -> {acc, :dont}
      ["do()"], {acc, _}  -> {acc, :do}
      ["don't()"], {acc, _} -> {acc, :dont}
    end)
  end
end
