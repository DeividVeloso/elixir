defmodule Discuss.Repo.Migrations.UpdateTableNameUserToUsers do
  use Ecto.Migration

  def up do
    drop(table("user"))

    create table(:users) do
      add(:email, :string)
      add(:provider, :string)
      add(:token, :string)

      timestamps()
    end
  end
end
