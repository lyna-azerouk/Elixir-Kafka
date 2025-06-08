defmodule KafkaXElixir.Repo.Migrations.AddCreditTable do
  use Ecto.Migration

  def change do
    create table(:credits) do
      add :amount, :decimal
      add :currency, :string
      add :description, :string
      add :account_id, :integer

      timestamps()
    end

    # create index(:credits, [:account_id])
    # create unique_index(:credits, [:account_id, :currency], name: :unique_account_currency)
  end
end
