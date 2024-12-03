defmodule Day2Part2 do
  def parse_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn xs -> Enum.map(xs, &String.to_integer/1) end)
  end

  def run(input) do
    input
    |> Enum.map(&check_with_level_removing/1)
    |> Enum.count(&(&1 == :safe))
  end

  def check_with_level_removing(xs) do
    cond do
      check(xs) == :safe -> :safe
      check(xs) == :unsafe ->
        levels_removed =  (0..length(xs)-1) |> Enum.map(fn i -> List.delete_at(xs, i) end)
        if Enum.any?(levels_removed, fn ys -> check(ys) == :safe end), do: :safe, else: :unsafe
      true -> :unsafe
    end
  end

  def check(xs) do
    check_helper(xs, nil, :unsafe)
  end

  # base
  def check_helper([], _, res) do
    res
  end

  def check_helper([_x], _, res) do
    res
  end

  # entry
  def check_helper([x, y | rest], nil, res) do
    check_helper([x, y | rest], direction(x, y), res)
  end

  def check_helper([x, y | rest], prev_dir, _res) do
    diff = abs(x - y)
    cur_dir = direction(x, y)
    cond do
      cur_dir != prev_dir -> check_helper([], cur_dir, :unsafe)
      diff > 0 && diff < 4 -> check_helper([y | rest], cur_dir, :safe)
      true -> check_helper([], cur_dir, :unsafe)
    end
  end

  defp direction(x, y) do
    cond do
      x > y -> :down
      x < y -> :up
      true -> :same
    end
  end
end
