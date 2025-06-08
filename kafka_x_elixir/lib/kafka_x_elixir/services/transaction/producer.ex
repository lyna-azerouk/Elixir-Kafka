defmodule KafkaXElixir.Services.BankAccount.Producer do
  @moduledoc false

  @topic "credit_card_transactions"

  def publish_event() do
    KafkaEx.produce(@topic, 0, "fkfgnkngkn")
  end
end
