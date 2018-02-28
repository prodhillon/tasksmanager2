defmodule Tasksmanager.Tracker.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasksmanager.Tracker.TimeBlock

  schema "timeblocks" do
    field :endtime, :naive_datetime
    field :starttime, :naive_datetime
    belongs_to :task , Tasksmanager.Tracker.Task

    timestamps()
  end

  @doc false
  def changeset(%TimeBlock{} = time_block, attrs) do
    time_block
    |> cast(attrs, [:starttime, :endtime, :task_id])
    |> validate_required([:starttime, :task_id])
  end
end
