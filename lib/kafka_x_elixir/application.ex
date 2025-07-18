defmodule KafkaXElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      # Starts a worker by calling: KafkaXElixir.Worker.start_link(arg)
      # {TelemetryMetricsPrometheus, [metrics: KafkaXElixir.Metrics.metrics()]},
      {KafkaXElixir.Services.BankAccounts.Pipeline, []},
      {KafkaXElixir.Repo, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KafkaXElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
