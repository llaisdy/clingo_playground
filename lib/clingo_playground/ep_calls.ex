defmodule ClingoPlayground.ElixirPython do
  @moduledoc """
  Documentation for ElixirPython.
  """

  @doc """
  ElixirPython

  ## Examples

      iex> ElixirPython.maybe_solution(%{{1,1} => 1, {1,2} =>1}, :sudoku9)
      {'error', %{}}

      iex> {'ok', smap} = ElixirPython.maybe_solution(%{{1,1} => 1, {1,2} =>3}, :sudoku9)
      iex> Map.get(smap, {3,3})
      {4, 'answer'}

      iex> {'ok', smap} = ElixirPython.maybe_solution(%{{1,1} => 1, {1,2} =>3}, :sudoku9)
      iex> length Map.keys(smap)
      81
  """

  def maybe_solution(grid, ruleset) do
    rules_fn = get_rules_fn(ruleset)
    call_python(:proc, :maybe_solution, [grid, rules_fn])
  end

  def maybe_valid_grid(grid, ruleset) do
    rules_fn = get_rules_fn(ruleset)
    call_python(:proc, :maybe_valid_grid, [grid, rules_fn])
  end

  defp default_instance() do
    #Load all modules in our priv/python directory
    path = [:code.priv_dir(:clingo_playground), "python"] 
          |> Path.join()
    python_instance(to_charlist(path))
  end

  # wrapper function to call python functions using
  # default python instance
  defp call_python(module, function, args) do
    default_instance()
    |> :python.call(module, function, args)
  end

  defp get_rules_fn(ruleset) do
    rulepath = ruleset_to_path(ruleset)
    [:code.priv_dir(:clingo_playground), rulepath]
    |> Path.join()
  end

  defp ruleset_to_path(:sudoku9), do: "asp/sudoku9.lp"
  defp ruleset_to_path(:sudoku6), do: "asp/sudoku6.lp"

    @doc """
  ## Parameters
    - path: directory to include in python path (charlist)
  """
  def python_instance(path) when is_list(path) do
    {:ok, pid} = :python.start([{:python_path, to_charlist(path)}])
    pid
  end

  def python_instance(_) do
    {:ok, pid} = :python.start()
    pid
  end
end
