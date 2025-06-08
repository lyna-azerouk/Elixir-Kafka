defmodule KafkaXElixir.Services.BankAccount.Consumer do
  use Broadway

  require Logger
  alias Broadway.Message

  def start_link(_opts) do
    IO.puts("Starting Broadway Consumer...")

    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module:
          {BroadwayKafka.Producer,
           [
             hosts: [localhost: 9092],
             group_id: "bank_account_group",
             topics: ["bank_account_events"]
           ]},
        concurrency: 1
      ],
      processors: [
        default: [
          concurrency: 2
        ]
      ],
      batchers: [
        default: [],
        credits: [
          batch_size: 5
        ],
        debits: [
          batch_size: 5
        ]
      ]
    )
  end

  @impl true
  def prepare_messages(messages, _context) do
    IO.puts("Preparing messages...")

    Enum.map(messages, fn message ->
      message
      |> Message.update_data(fn data ->
        Jason.decode(data)
      end)
    end)
  end

  @impl true
  def handle_message(_processor, %Message{data: {:ok, data}} = message, _context) do
    IO.inspect(message, label: "Received message")

    case data do
      %{"event_type" => "credit"} ->
        Message.put_batcher(message, :credits)

      %{"event_type" => "debit"} ->
        Message.put_batcher(message, :debits)

      _ ->
        Message.failed(message, "invalid-event-data")
    end
  end

  def handle_message(_processor, %Message{data: {:error, _error}} = message, _context) do
    Message.failed(message, "invalid-event-data")
  end

  @impl true
  def handle_failed(messages, _context) do
    Enum.map(messages, fn
      %{status: %{failed: "invalid-event-data"}} = message ->
        Broadway.Message.configure_ack(message, on_failure: :ack)
        Logger.error("Failed to process message: #{inspect(message.data)}")

      message ->
        Logger.error("Failed to process message: #{inspect(message.data)}")
        message
    end)
  end

  @impl true
  def handle_batch(batcher, messages, %Broadway.BatchInfo{batcher: :credits}, _context) do
    IO.inspect(messages, label: "Handling batch of messages")
    IO.puts("Batcher: #{batcher}")
    IO.puts("Handling batch...")
    ## insert all credits into the database
    messages
  end

  def handle_batch(batcher, messages, %Broadway.BatchInfo{batcher: :debits}, _context) do
    IO.inspect(messages, label: "Handling batch of messages")
    IO.puts("Batcher: #{batcher}")
    IO.puts("Handling batch...")
    list = messages |> Enum.map(fn e -> e.data end)
    IO.inspect(list, label: "Got batch")
    messages
  end
end
