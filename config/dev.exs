import Config

config :kafka_x_elixir,
  ecto_repos: [KafkaXElixir.Repo]

config :kafka_x_elixir, KafkaXElixir.Repo,
  # adjust these to match your Postgres setup
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
