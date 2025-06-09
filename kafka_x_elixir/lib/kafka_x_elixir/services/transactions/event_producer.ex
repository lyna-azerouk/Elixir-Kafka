defmodule KafkaXElixir.Services.BankAccount.EventProducer do
  @moduledoc """
  Simule une API qui produit N événements sur le topic Kafka.
  """

  @topic "bank_account_events"
  @batch_size 1_000
  def send_many(n) when is_integer(n) and n > 0 do
    1..n
    |> Stream.map(&build_message/1)
    |> Stream.chunk_every(@batch_size)
    |> Stream.each(fn batch ->
      :ok = Kaffe.Producer.produce_sync(@topic, batch)
    end)
    |> Stream.run()
  end

  defp build_message(i) do
    event = %{
      event_type: "credit",
      credit: %{
        amount: "50",
        currency: "euros",
        account_id: to_string(i)
      }
    }

    %{
      key: event.credit.account_id,
      value: Jason.encode!(event)
    }
  end
end
