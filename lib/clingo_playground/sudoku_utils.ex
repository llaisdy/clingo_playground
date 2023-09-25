 defmodule ClingoPlayground.SudokuUtils do
  
  def size_to_ruleset size do
    case size do
      6 -> :sudoku6
      9 -> :sudoku9
    end
  end

  def sudoku_value(smap, key) do
      case Map.get(smap, key) do
        nil        -> ''
	{value, _} -> value
	value      -> value
      end
  end

  def sudoku_style(smap, key) do
    case Map.get(smap, key) do
      {_, style} -> List.to_string(style)
      nil        -> "empty"
      _          -> "question"
    end
  end

  def map_sudoku(input, size) do
    try do
      for {row_str, num_strs_by_col_str} <- input,
          {col_str, num_str} <- num_strs_by_col_str,
          num_str != "",
          row = String.to_integer(row_str),
          col = String.to_integer(col_str),
          num = valid_cell_val(num_str, size),
          into: %{} do
        {{row, col}, num}
      end
    rescue
      _ ->
        {"error", "Invalid entry"}
    end
  end

  defp valid_cell_val(num_str, size) do
    n =  String.to_integer(num_str)
    case 1 <= n and n <= size do
      true -> n
      false -> raise "number out of range"
    end
  end
end
