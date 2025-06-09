import Config

config :kafka_ex,
  brokers: [
    {"localhost", 9092}
  ],
  consumer_group: "bank_account_group",
  protocol_version: {2, 0, 0},
  disable_default_worker: false

config :kafka_x_elixir,
  ecto_repos: [KafkaXElixir.Repo]

config :kafka_x_elixir, KafkaXElixir.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "kafka_x_elixir_dev",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :kaffe,
  producer: [
    endpoints: [localhost: 9092],
    topics: ["bank_account_events"]
  ]
