defmodule Tasksmanager.Tracker.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasksmanager.Tracker.Task


  schema "tasks" do
    field :completed, :string
    field :description, :string
    field :timespent, :integer
    field :title, :string
    belongs_to :user, Tasksmanager.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :timespent, :user_id])
    |> validate_required([:title, :description, :user_id])

  end

end
