defmodule KafkaXElixir.Repo.Migrations.AddDebitTable do
  use Ecto.Migration

  def change do
    create table(:debits) do
      add :amount, :string
      add :currency, :string
      add :credit_id, :string
      add :reason, :string
      add :payment_method, :string
    end
  end
end
