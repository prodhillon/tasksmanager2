defmodule TasksmanagerWeb.TimeBlockController do
  use TasksmanagerWeb, :controller
  import Ecto.Query, warn: false
  alias Tasksmanager.Repo

  alias Tasksmanager.Tracker
  alias Tasksmanager.Tracker.TimeBlock

  action_fallback TasksmanagerWeb.FallbackController

  def index(conn, _params) do
    timeblocks = Tracker.list_timeblocks()
    render(conn, "index.json", timeblocks: timeblocks)
  end

  def create(conn, %{"time_block" => time_block_params}) do
    IO.inspect("Inside timeblock")


    with {:ok, %TimeBlock{} = time_block} <- Tracker.create_time_block(time_block_params) do
      query = from(t in TimeBlock, select: t.task_id, where: t.id == ^time_block.id)
      task = Repo.all(query)
      taskid= Enum.at(task,0)
      conn
      |> put_status(:created)
     |> put_resp_header("location", time_block_path(conn, :show, time_block))
     |> render("show.json", time_block: time_block)
    end
  end

  def show(conn, %{"id" => id}) do
    time_block = Tracker.get_time_block!(id)
    render(conn, "show.json", time_block: time_block)
  end

  def new(conn, %{"time_block" => time_block_params}) do
    IO.inspect("Inside edit ooo" )
    IO.inspect("Inside timeblock")
    with {:ok, %TimeBlock{} = time_block} <- Tracker.create_time_block(time_block_params) do
      query = from(t in TimeBlock, select: t.task_id, where: t.id == ^time_block.id)
      task = Repo.all(query)
      taskid= Enum.at(task,0)
      conn
      |> put_status(:created)
      |> put_resp_header("location", time_block_path(conn, :show, time_block))
      |> render("show.json", time_block: time_block)

    end
  end

  def update(conn, %{"id" => id, "time_block" => time_block_params}) do
    IO.inspect("Inside update")
    time_block = Tracker.get_time_block!(id)
    with {:ok, %TimeBlock{} = time_block} <- Tracker.update_time_block(time_block, time_block_params) do
      render(conn, "show.json", time_block: time_block)
    end
  end

  def delete(conn, %{"id" => id}) do
    time_block = Tracker.get_time_block!(id)
    query = from(t in TimeBlock, select: t.task_id, where: t.id == ^id)
    task = Repo.all(query)
    taskid= Enum.at(task,0)
    IO.inspect(taskid)
    with {:ok, %TimeBlock{}} <- Tracker.delete_time_block(time_block) do
     conn
    |> redirect(to: task_path(conn, :show, taskid))
     send_resp(conn, :no_content, "")

   end

  end
end
