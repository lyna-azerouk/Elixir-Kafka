import Config

config :kafka_ex,
  brokers: [
    {"localhost", 9092}
  ],
  consumer_group: "group_1",
  protocol_version: {2, 0, 0},
  disable_default_worker: false

config :kafka_x_elixir,
  ecto_repos: [KafkaXElixir.Repo]
