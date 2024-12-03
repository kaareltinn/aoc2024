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
    |> Enum.map(&check/1)
    |> Enum.count(&(&1 == :safe))
  end

  def check(xs) do
    check_helper(xs, nil, :unsafe, [], false)
  end

  # base
  def check_helper([], _, res, _, _) do
    res
  end

  def check_helper([_x], _, res, _, _) do
    res
  end

  # entry
  def check_helper([x, y | rest], nil, res, visited, false) do
    check_helper([x, y | rest], direction(x, y), res, visited, false)
  end

  def check_helper([x, y | rest], prev_dir, _res, visited, changed) do
    diff = abs(x - y)
    cur_dir = direction(x, y)
    visited_new = visited ++ [x]

    dbg()

    cond do
      diff < 4 ->
        if diff == 0 and !changed do
          check_helper(visited ++ [y] ++ rest, prev_dir, :unsafe, visited, true)
        else
          check_helper([y | rest], cur_dir, :safe, visited_new, changed)
        end

      diff == 0 ->
        if changed do
          check_helper([], cur_dir, :unsafe, visited_new, true)
        else
          check_helper(visited ++ [y] ++ rest, prev_dir, :unsafe, visited, true)
        end

      true ->
        if changed do
          check_helper([], cur_dir, :unsafe, visited_new, true)
        else
          check_helper(visited ++ [y] ++ rest, cur_dir, :unsafe, visited, true)
        end
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
