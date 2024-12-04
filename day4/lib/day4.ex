defmodule Day4 do
  def parse_input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
  end

  @xmas {"X", "M", "A", "S"}

  @vertical_forward [[0, 0], [1, 0], [2, 0], [3, 0]]
  @vertical_backward [[0, 0], [-1, 0], [-2, 0], [-3, 0]]
  @horizontal_forward [[0, 0], [0, 1], [0, 2], [0, 3]]
  @horizontal_backward [[0, 0], [0, -1], [0, -2], [0, -3]]
  @diagonal_bottom_right [[0, 0], [1, 1], [2, 2], [3, 3]]
  @diagonal_bottom_left [[0, 0], [-1, 1], [-2, 2], [-3, 3]]
  @diagonal_top_right [[0, 0], [1, -1], [2, -2], [3, -3]]
  @diagonal_top_left [[0, 0], [-1, -1], [-2, -2], [-3, -3]]

  def part1(input) do
    for i <- 0..(length(List.first(input)) - 1) do
      for j <- 0..(length(input) - 1) do
        if input |> Enum.at(j) |> Enum.at(i) == "X" do
          check_directions(input, i, j)
        else
          0
        end
      end
    end
    |> List.flatten()
    |> Enum.sum()
  end

  defp check_directions(input, i, j) do
    [
      check_vertical_forward(input, i, j),
      check_vertical_backward(input, i, j),
      check_horizontal_forward(input, i, j),
      check_horizontal_backward(input, i, j),
      check_diagonal_bottom_right(input, i, j),
      check_diagonal_bottom_left(input, i, j),
      check_diagonal_top_right(input, i, j),
      check_diagonal_top_left(input, i, j)
    ]
    |> Enum.filter(& &1)
    |> length()
  end

  def check_vertical_forward(input, i, j) do
    check_direction(input, i, j, @vertical_forward)
  end

  def check_vertical_backward(input, i, j) do
    check_direction(input, i, j, @vertical_backward)
  end

  def check_horizontal_forward(input, i, j) do
    check_direction(input, i, j, @horizontal_forward)
  end

  def check_horizontal_backward(input, i, j) do
    check_direction(input, i, j, @horizontal_backward)
  end

  def check_diagonal_bottom_right(input, i, j) do
    check_direction(input, i, j, @diagonal_bottom_right)
  end

  def check_diagonal_bottom_left(input, i, j) do
    check_direction(input, i, j, @diagonal_bottom_left)
  end

  def check_diagonal_top_right(input, i, j) do
    check_direction(input, i, j, @diagonal_top_right)
  end

  def check_diagonal_top_left(input, i, j) do
    check_direction(input, i, j, @diagonal_top_left)
  end

  def check_direction(input, x, y, direction) do
    direction
    |> Enum.with_index(fn element, index -> {index, element} end)
    |> Enum.reduce_while(true, fn {index, [x_offset, y_offset]}, _acc ->
      dx = x + x_offset 
      dy = y + y_offset

      cond do
        dx < 0 or dx >= length(List.first(input)) -> {:halt, false}
        dy < 0 or dy >= length(input) -> {:halt, false}
        true -> 
          row = Enum.at(input, dy)
          element = Enum.at(row, dx)

          if element == elem(@xmas, index)  do
            {:cont, true}
          else
            {:halt, false}
          end
      end
    end)
  end

  # M . S
  # . A .
  # M . S
  @variant1 [
    {-1, -1, "M"}, # top-left
    {1, -1, "S"}, # top-right
    {1, 1, "S"}, # bottom-right
    {-1, 1, "M"} # bottom-left
  ]

  # M . M
  # . A .
  # S . S
  @variant2 [
    {-1, -1, "M"},
    {1, -1, "M"},
    {1, 1, "S"},
    {-1, 1, "S"}
  ]

  # S . M
  # . A .
  # S . M
  @variant3 [
    {-1, -1, "S"},
    {1, -1, "M"},
    {1, 1, "M"},
    {-1, 1, "S"}
  ]

  # S . S
  # . A .
  # M . M
  @variant4 [
    {-1, -1, "S"},
    {1, -1, "S"},
    {1, 1, "M"},
    {-1, 1, "M"}
  ]

  def part2(input) do
    for i <- 0..(length(List.first(input)) - 1) do
      for j <- 0..(length(input) - 1) do
        if input |> Enum.at(j) |> Enum.at(i) == "A" do
          check_x_mases(input, i, j)
        else
          0
        end
      end
    end
    |> List.flatten()
    |> Enum.sum()
  end

  def check_x_mases(input, i, j) do
    res = [
      check_variant(input, i, j, @variant1),
      check_variant(input, i, j, @variant2),
      check_variant(input, i, j, @variant3),
      check_variant(input, i, j, @variant4)
    ]
    |> Enum.any?()

    if res do
      1
    else
      0
    end
  end

  def check_variant(input, x, y, variant) do
    variant
    |> Enum.reduce_while(true, fn {x_offset, y_offset, letter}, _acc ->
      dx = x + x_offset 
      dy = y + y_offset

      cond do
        dx < 0 or dx >= length(List.first(input)) -> {:halt, false}
        dy < 0 or dy >= length(input) -> {:halt, false}
        true -> 
          row = Enum.at(input, dy)
          element = Enum.at(row, dx)

          if element == letter  do
            {:cont, true}
          else
            {:halt, false}
          end
      end
    end)
  end
end
