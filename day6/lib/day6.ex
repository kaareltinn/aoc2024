defmodule Day6 do
  defstruct current_location: {0, 0},
            current_direction: {0, -1},
            visited: %{},
            board: %{}

  @right {1,0}
  @left {-1, 0}
  @up {0, -1}
  @down {0, 1}

  def run do
    Benchee.run(%{
      "part1" => fn -> "input.txt" |> parse_input() |> init() |> part1() end,
      # "part2" => fn -> "input.txt" |> parse_input() |> part2() end
    })
  end

  def parse_input(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
  end

  def init(input) do
    state = struct!(__MODULE__)

    input
    |> Enum.with_index()
    |> Enum.reduce(state, fn {row, y}, state ->
      row
      |> Enum.with_index()
      |> Enum.reduce(state, fn {cell, x}, state ->
        case cell do
          "." ->
            %Day6{state | board: put_in(state.board, [{x, y}], cell)}

          "#" ->
            %Day6{state | board: put_in(state.board, [{x, y}], cell)}

          "^" ->
            state = %Day6{state | current_location: {x, y}}
            state = %Day6{state | visited: %{{x, y} => 1}}
            %Day6{state | board: put_in(state.board, [{x, y}], ".")}
        end
      end)
    end)
  end

  def move(state) do
    {cur_x, cur_y} = state.current_location
    {dir_x, dir_y} = state.current_direction

    new_location = {cur_x + dir_x, cur_y + dir_y}

    case Map.get(state.board, new_location) do
      "." ->
        state =
          state
          |> Map.put(:current_location, new_location)
          |> Map.update(
            :visited,
            state.visited,
            fn visited ->
              Map.update(visited, new_location, 1, &(&1 + 1))
            end
          )

        {:ok, state}

      "#" ->
        state =
          state
          |> Map.put(:current_direction, turn(state.current_direction))

        {:ok, state}

      nil ->
        state = Map.put(state, :current_location, :out_of_bounds)
        {:out_of_bounds, state}
    end
  end

  def walk_path(%{current_location: :out_of_bounds} = state) do
    state
  end

  def walk_path(state) do
    {_, state} = move(state)
    walk_path(state)
  end

  def part1(state) do
    state = walk_path(state)

    state.visited
    |> Enum.into([])
    |> length()
  end

  def turn(@up), do: @right
  def turn(@right), do: @down
  def turn(@down), do: @left
  def turn(@left), do: @up
end
