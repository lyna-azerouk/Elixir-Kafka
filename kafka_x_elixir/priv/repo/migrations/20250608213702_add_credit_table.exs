defmodule KafkaXElixir.Repo.Migrations.AddCreditTable do
  use Ecto.Migration

  def change do
    create table(:credits) do
      add :amount, :string
      add :currency, :string
      add :description, :string
      add :account_id, :string
    end
  end
end
