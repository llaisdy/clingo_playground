defmodule ClingoPlayground.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ClingoPlaygroundWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ClingoPlayground.PubSub},
      # Start Finch
      {Finch, name: ClingoPlayground.Finch},
      # Start the Endpoint (http/https)
      ClingoPlaygroundWeb.Endpoint
      # Start a worker by calling: ClingoPlayground.Worker.start_link(arg)
      # {ClingoPlayground.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ClingoPlayground.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ClingoPlaygroundWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
