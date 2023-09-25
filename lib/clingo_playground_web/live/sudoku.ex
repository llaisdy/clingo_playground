 defmodule ClingoPlaygroundWeb.Sudoku do
  use ClingoPlaygroundWeb, :live_view

  alias ClingoPlayground.ElixirPython
  alias ClingoPlayground.SudokuUtils, as: SUtils
  
  def mount(%{"size" => num_str}, _session, socket) do
    sudoku = %{}
    size = num_str_to_size(num_str)
    {:ok,
     assign(socket,
       sudoku: sudoku,
       sudoku_size: size,
       message: '',
       message_class: :ok
     )}
  end

  defp num_str_to_size x do
    case x do
      "6" -> 6
      _ -> 9
    end
  end

  def render(assigns) do
    ~H"""
    <form phx-change="maybe_valid_grid" phx-submit="maybe_solve">
      <div class="sudoku">
      <table>
        <colgroup><col><col><col></colgroup>
        <colgroup><col><col><col></colgroup>
        <colgroup><col><col><col></colgroup>
            <%= for row <- 1..@sudoku_size do %>
              <tr>
                <%= for col <- 1..@sudoku_size do %>
                  <td><input
                         pattern={"[1-#{@sudoku_size}]"} maxlength="1" size="1"
                         name={"input[#{row}][#{col}]"}
                         value={SUtils.sudoku_value(@sudoku, {row, col})}
                         class={SUtils.sudoku_style(@sudoku, {row, col})}
                       /></td>
                <% end %>
              </tr>
              <%= maybe_tbody(row, @sudoku_size) %>
            <% end %>
      </table>
      </div>
      <CustomComponents.form_footer msg_class={@message_class} msg={@message} />
    </form>
    """
  end

  def maybe_tbody(row, size) do
    rows =
      case size do
        6 -> [2,4]
        9 -> [3,6]
      end
    case Enum.member?(rows, row) do
      :true  -> Phoenix.HTML.raw "<tbody>"
      :false -> ""
    end
  end

  def handle_event("maybe_valid_grid", %{"input" => input}, socket) do
    size = socket.assigns.sudoku_size
    rset = SUtils.size_to_ruleset size
    case SUtils.map_sudoku(input, size) do
      {"error", message} ->
        {:noreply, assign(socket,
            message: message,
	    message_class: "error")}
      smap ->
        {class, message} = ElixirPython.maybe_valid_grid(smap, rset)
        {:noreply, assign(socket,
            message: message,
	    message_class: class,
	    sudoku: smap)}
    end
  end

  def handle_event("maybe_solve", %{"input" => input}, socket) do
    size = socket.assigns.sudoku_size
    rset = SUtils.size_to_ruleset size
    smap = SUtils.map_sudoku(input, size)

    case ElixirPython.maybe_solution(smap, rset) do
      {'ok', new_sudoku} ->
	{:noreply, assign(socket,
	    message: 'Solved!',
	    message_class: :ok,
	    sudoku: new_sudoku)}
      {'error', _} ->
	{:noreply, assign(socket,
	    message: 'No solutions!',
	    message_class: :error)}
    end
  end
end
