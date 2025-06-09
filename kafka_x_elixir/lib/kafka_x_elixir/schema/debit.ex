defmodule KafkaXElixir.Schema.Debit do

  use Ecto.Schema
  import Ecto.Changeset

  schema "debits" do
    field(:amount, :string)
    field(:currency, :string)
    field(:credit_id, :string)
    field(:reason, :string)
    field(:payment_method, :string)
  end

  @doc false
  def changeset(debit, attrs) do
    debit
    |> cast(attrs, [:amount, :currency, :payment_method, :reason])
    |> validate_required([:amount, :currency])
  end
end
