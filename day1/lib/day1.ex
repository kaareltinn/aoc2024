defmodule Day1 do
  def parse_input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_element/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.sort/1)
  end

  def part1(input) do
    input
    |> Enum.zip()
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def part2([left, right]) do
    h =
      right
      |> Enum.group_by(fn x -> x end)
      |> Map.new(fn {k, v} -> {k, Enum.count(v)} end)

    left
    |> Enum.reduce(0, fn x, acc ->
      case Map.get(h, x) do
        nil -> acc
        count -> acc + (count * x)
      end
    end)
  end

  defp parse_element(element) do
    String.split(element, " ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
