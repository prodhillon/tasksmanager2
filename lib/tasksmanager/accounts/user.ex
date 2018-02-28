defmodule Tasksmanager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasksmanager.Accounts.User


  schema "users" do
    field :email, :string
    field :name, :string
    field :manager, :string
    belongs_to :select_manager, Tasksmanager.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :manager, :select_manager_id])
    |> validate_required([:email, :name])
    |> unique_constraint(:email)
  end
end
