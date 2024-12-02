defmodule Part1 do
  def parse_input(filename) do
    File.read!(filename)
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end
end
