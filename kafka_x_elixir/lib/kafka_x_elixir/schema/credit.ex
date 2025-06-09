defmodule KafkaXElixir.Schema.Credit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "credits" do
    field(:amount, :string)
    field(:currency, :string)
    field(:description, :string)
    field(:account_id, :string)
  end

  @doc false
  def changeset(credit, attrs) do
    credit
    |> cast(attrs, [:amount, :currency, :description, :account_id])
    |> validate_required([:amount, :currency, :account_id])
  end
end
