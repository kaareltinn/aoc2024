defmodule Day5 do
  defstruct rules: [],
            all_updates: [],
            correct_updates: [],
            incorrect_updates: [],
            failed_rules: []

  def run do
    # "input.txt"
    # |> parse_input()
    # |> part1()
    # |> IO.inspect(label: "Part 1")
    #
    Benchee.run(%{
      "part1" => fn -> "input.txt" |> parse_input() |> part1() end,
      "part2" => fn -> "input.txt" |> parse_input() |> part2() end
    })
  end

  def parse_input(file) do
    [rules, updates] =
      File.read!(file)
      |> String.split("\n\n", trim: true)

    rules =
      rules
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, "|", trim: true))
      |> Enum.map(fn [x, y] -> {String.to_integer(x), String.to_integer(y)} end)

    updates =
      updates
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, ",", trim: true))
      |> Enum.map(fn xs -> Enum.map(xs, &String.to_integer/1) end)

    %Day5{rules: rules, all_updates: updates}
  end

  def part1(%Day5{all_updates: updates} = state) do
    state =
      updates
      |> Enum.reduce(state, fn update, acc ->
        {_, is_good} = check_update(update, acc)

        case is_good do
          true -> %{acc | correct_updates: [update | acc.correct_updates]}
          false -> acc
        end
      end)

    state.correct_updates
    |> Enum.reduce(0, fn xs, acc ->
      index = floor(length(xs) / 2)
      acc + Enum.at(xs, index)
    end)
  end

  def part2(%Day5{all_updates: updates} = state) do
    state =
      updates
      |> Enum.reduce(state, fn update, acc ->
        case check_update(update, acc) do
          {_failed_rules, false} ->
            %{
              acc
              | incorrect_updates: [sort_update(update, state.rules) | acc.incorrect_updates]
            }

          {_, true} ->
            acc
        end
      end)

    state.incorrect_updates
    |> Enum.reduce(0, fn xs, acc ->
      index = floor(length(xs) / 2)
      acc + Enum.at(xs, index)
    end)
  end

  def sort_update(update, rules) do
    case check_rules(rules, update) do
      {_, true} -> update
      {_, false} ->
        sorted = sort_update_helper(update, rules, false)
        sort_update(sorted, rules)
    end
  end

  def sort_update_helper(update, _rules, true) do
    update
  end

  def sort_update_helper(update, rules, false) do
    Enum.reduce(rules, update, fn {x, y}, acc ->
      x_i = Enum.find_index(acc, &(&1 == x))
      y_i = Enum.find_index(acc, &(&1 == y))

      _updated_acc = cond do
        x_i == nil && y_i == nil -> acc
        x_i == nil -> acc
        y_i == nil -> acc
        y_i < x_i ->
          acc
          |> List.replace_at(x_i, y)
          |> List.replace_at(y_i, x)
        true -> acc
      end
    end)
  end

  def find_relevant_rules(update, state) do
    state.rules
    |> Enum.filter(fn {x, y} ->
      Enum.member?(update, x) && Enum.member?(update, y)
    end)
  end

  def check_update(update, state) do
    update
    |> find_relevant_rules(state)
    |> check_rules(update)
  end

  def build_update_variations(update) do
    {_, res} =
      Enum.reduce(update, {tl(update), []}, fn x, {rest, res} ->
        case rest do
          [] -> {[], res}
          [tail] -> {[], [{x, tail} | res]}
          _ -> {tl(rest), Enum.map(rest, fn y -> {x, y} end) ++ res}
        end
      end)

    res
  end

  def check_rules(rules, update) do
    variations = build_update_variations(update)

    rules
    |> Enum.reduce({[], true}, fn rule, {failed_rules, is_good} ->
      {failed_rules_new, is_good} =
        variations
        |> Enum.reduce({failed_rules, is_good}, fn {var_x, var_y}, {failed_rules_inner, is_good} ->
          case rule do
            {^var_y, ^var_x} -> {[rule | failed_rules_inner], false}
            {^var_x, ^var_y} -> {failed_rules_inner, is_good}
            _ -> {failed_rules_inner, is_good}
          end
        end)

      {failed_rules_new, is_good}
    end)
  end
end
