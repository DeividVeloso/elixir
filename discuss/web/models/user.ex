defmodule Discuss.User do
  use Discuss.Web, :model

  # access User Table
  schema "users" do
    field(:email, :string)
    field(:provider, :string)
    field(:token, :string)
    has_many :topics, Discuss.Topic

    timestamps()
  end

  # Generate my commands to run in Database(UPDATE, INSERT, ...)
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
