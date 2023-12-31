defmodule SudokuTest do
  use ExUnit.Case
  alias ClingoPlayground.ElixirPython

  test "returns a solved Sudoku as it is" do
    input = [
      [2, 8, 3, 1, 4, 6, 5, 9, 7],
      [7, 9, 5, 3, 8, 2, 1, 4, 6],
      [4, 6, 1, 9, 5, 7, 2, 8, 3],
      [6, 3, 4, 2, 9, 8, 7, 5, 1],
      [1, 5, 8, 7, 6, 3, 4, 2, 9],
      [9, 2, 7, 5, 1, 4, 6, 3, 8],
      [3, 1, 6, 4, 2, 9, 8, 7, 5],
      [5, 7, 2, 8, 3, 1, 9, 6, 4],
      [8, 4, 9, 6, 7, 5, 3, 1, 2]
    ]

    assert test_solve(input) == input
  end

  test "solves a Sudoku from https://www.sudokuweb.org/" do
    input = [
      [2, 8, 3, 1, 0, 0, 0, 0, 7],
      [7, 0, 0, 0, 0, 0, 0, 4, 0],
      [4, 0, 0, 0, 0, 0, 2, 0, 3],
      [6, 3, 0, 2, 0, 0, 7, 0, 0],
      [0, 5, 0, 0, 6, 3, 4, 0, 9],
      [0, 0, 7, 5, 0, 4, 0, 3, 8],
      [3, 1, 0, 0, 2, 0, 8, 7, 5],
      [5, 7, 0, 0, 0, 1, 9, 0, 4],
      [0, 4, 9, 6, 7, 5, 3, 1, 0]
    ]

    assert test_solve(input) ==
             [
               [2, 8, 3, 1, 4, 6, 5, 9, 7],
               [7, 9, 5, 3, 8, 2, 1, 4, 6],
               [4, 6, 1, 9, 5, 7, 2, 8, 3],
               [6, 3, 4, 2, 9, 8, 7, 5, 1],
               [1, 5, 8, 7, 6, 3, 4, 2, 9],
               [9, 2, 7, 5, 1, 4, 6, 3, 8],
               [3, 1, 6, 4, 2, 9, 8, 7, 5],
               [5, 7, 2, 8, 3, 1, 9, 6, 4],
               [8, 4, 9, 6, 7, 5, 3, 1, 2]
             ]
  end

  test "solves a Sudoku from http://sudoku.becher-sundstroem.de/" do
    input = [
      [0, 0, 3, 0, 0, 9, 0, 0, 0],
      [0, 0, 0, 0, 0, 1, 2, 9, 0],
      [7, 0, 0, 0, 5, 0, 1, 0, 0],
      [3, 0, 0, 0, 9, 0, 0, 4, 0],
      [0, 6, 0, 0, 0, 0, 0, 0, 7],
      [5, 9, 0, 6, 0, 8, 0, 0, 0],
      [0, 5, 0, 0, 7, 0, 4, 0, 0],
      [0, 0, 1, 2, 0, 0, 0, 0, 9],
      [8, 0, 0, 0, 0, 0, 7, 0, 0]
    ]

    assert test_solve(input) == [
             [2, 1, 3, 4, 6, 9, 8, 7, 5],
             [6, 8, 5, 7, 3, 1, 2, 9, 4],
             [7, 4, 9, 8, 5, 2, 1, 6, 3],
             [3, 2, 8, 1, 9, 7, 5, 4, 6],
             [1, 6, 4, 5, 2, 3, 9, 8, 7],
             [5, 9, 7, 6, 4, 8, 3, 2, 1],
             [9, 5, 2, 3, 7, 6, 4, 1, 8],
             [4, 7, 1, 2, 8, 5, 6, 3, 9],
             [8, 3, 6, 9, 1, 4, 7, 5, 2]
           ]
  end

  test "solves a Sudoku from https://kjell.haxx.se/sudoku/" do
    input = [
      [0, 0, 8, 0, 3, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 1, 0, 0],
      [0, 4, 0, 0, 0, 0, 0, 6, 0],
      [0, 0, 9, 0, 0, 0, 0, 0, 2],
      [0, 0, 0, 4, 0, 0, 0, 0, 0],
      [5, 0, 0, 1, 0, 6, 9, 0, 0],
      [0, 0, 0, 0, 2, 0, 7, 0, 0],
      [6, 1, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 8]
    ]

    assert test_solve(input) == [
             [7, 6, 8, 9, 3, 1, 2, 5, 4],
             [2, 9, 5, 8, 6, 4, 1, 3, 7],
             [3, 4, 1, 2, 5, 7, 8, 6, 9],
             [1, 7, 9, 3, 8, 5, 6, 4, 2],
             [8, 3, 6, 4, 9, 2, 5, 7, 1],
             [5, 2, 4, 1, 7, 6, 9, 8, 3],
             [4, 8, 3, 5, 2, 9, 7, 1, 6],
             [6, 1, 2, 7, 4, 8, 3, 9, 5],
             [9, 5, 7, 6, 1, 3, 4, 2, 8]
           ]
  end

  defp test_solve(input) do
    case input
    |> input_to_map()
    |> ElixirPython.maybe_solution(:sudoku9) do
      {'ok', solution} -> map_to_output(solution)
      {'error', _}     -> :error
    end
  end

  defp get_rules_dir() do
    [:code.priv_dir(:composer_cli), 'asp']
    |> Path.join()
  end

  defp input_to_map(input) do
    for {row, i} <- Enum.with_index(input),
      {num, j} <- Enum.with_index(row),
      num != 0,
      into: %{},
      do: {{i+1, j+1}, num}
  end

  defp map_to_output(smap) do
    for i <- 1..9 do
      for j <- 1..9 do
	{num, _} = Map.get(smap, {i, j}, 0)
	num
      end
    end
  end
end
