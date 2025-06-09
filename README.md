# Elixir Kafka

In this demo, a producer publishes two types of events—credit and debit—each to its own Kafka topic.
A downstream processing pipeline (one or more Kafka consumers) subscribes to both topics, consumes incoming events, and groups them into separate batches
(one batch for credit events, one for debit). Each batch is then processed independently—in this simple example, processing consists
of persisting the events into a database.

## Kafka
    docker run -p 9092:9092 apache/kafka:4.0.0

#### Create a topic
    bin/kafka-topics.sh --create --topic bank_account_events --bootstrap-server localhost:9092


## Run Pipeline

    mix deps.get

    mix ecto.create

    mix ecto.migrate

--

    iex -S mix

## Send events to Kafka
    iex> KafkaXElixir.Services.BankAccount.EventProducer.send_many(5)

The pipeline will process the event, so you should see:

>| **19:49:03.488 [info] Inserted 3 credits into the database**

