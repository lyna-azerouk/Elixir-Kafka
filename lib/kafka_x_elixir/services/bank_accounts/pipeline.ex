defmodule KafkaXElixir.Services.BankAccounts.Pipeline do
  @doc """
  Consume events from the Kafka topic `bank_account_events`

  messages are stored in database
  """
  use Broadway

  require Logger
  alias Broadway.Message
  alias KafkaXElixir.Schema.Credit
  alias KafkaXElixir.Schema.Debit
  alias KafkaXElixir.Repo

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
        concurrency: 2
      ],
      processors: [
        default: [
          concurrency: 2
        ]
      ],
      batchers: [
        default: [],
        credits: [
          batch_size: 5,
          batch_timeout: 5_000
        ],
        debits: [
          batch_size: 5
        ]
      ]
    )
  end

  @impl true
  def prepare_messages(messages, _context) do
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
    batch_insert_all(Credit, messages)
  end

  def handle_batch(batcher, messages, %Broadway.BatchInfo{batcher: :debits}, _context) do
    batch_insert_all(Debit, messages)
  end

  defp batch_insert_all(schema, messages, opts \\ []) do
    entries =
      convert_baches_to_entries(schema, messages)

    Repo.insert_all(schema, entries, opts)
    |> case do
      {n, _} ->
        Logger.info("Inserted #{n} credits into the database")
        messages

      _ ->
        messages
    end
  end

  defp convert_baches_to_entries(schema, messages) do
    Enum.map(messages, fn %Message{data: data} ->
      case data do
        {:ok, %{"credit" => credit_attrs}} ->
          %Ecto.Changeset{changes: changes} = schema |> struct() |> schema.changeset(credit_attrs)
          changes

        _ ->
          Logger.error("Failed to decode message data: #{inspect(data)}")
      end
    end)
  end
end
