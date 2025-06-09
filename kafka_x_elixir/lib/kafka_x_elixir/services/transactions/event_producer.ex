defmodule KafkaXElixir.Services.BankAccount.EventProducer do
  @moduledoc """
  Simule une API qui produit N événements sur le topic Kafka.
  """

  @topic "bank_account_events"
  @batch_size 1_000
  def send_many(n) when is_integer(n) and n > 0 do
    1..n
    |> Stream.map(fn _ -> build_message() end)
    |> Stream.chunk_every(@batch_size)
    |> Stream.each(fn batch ->
      :ok = Kaffe.Producer.produce_sync(@topic, batch)
    end)
    |> Stream.run()
  end

  defp build_message() do
    case :rand.uniform(2) do
      1 -> build_debit_event()
      2 -> build_credit_event()
    end
  end

  defp build_debit_event() do
    event = %{
      event_type: "debit",
      credit: %{
        amount: "50",
        currency: "euros",
        reason: "12345",
        payment_method: "12345",
        credit_id: "12345"
      }
    }

    %{
      key: event.credit.credit_id,
      value: Jason.encode!(event)
    }
  end


  defp build_credit_event() do
    event = %{
      event_type: "credit",
      credit: %{
        amount: "100",
        currency: "euros",
        description: "12345",
        account_id: "12345"
      }
    }

    %{
      key: event.credit.account_id,
      value: Jason.encode!(event)
    }
  end
end
