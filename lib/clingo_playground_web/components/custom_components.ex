defmodule ClingoPlaygroundWeb.CustomComponents do
  use Phoenix.Component

    def form_footer(assigns) do
    ~H"""
    <div class="form_footer">
      <button class="btn btn-green">Solve</button>
      <a class="btn btn-blue" href="">Reset</a>
      <p class={"#{@msg_class}"}><%= @msg %></p>
    </div>
    """
    end
end
