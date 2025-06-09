defmodule KafkaXElixir.Repo do
  use Ecto.Repo,
    otp_app: :kafka_x_elixir,
    # or whatever adapter you use
    adapter: Ecto.Adapters.Postgres
end
