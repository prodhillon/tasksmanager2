defmodule TasksmanagerWeb.TaskController do
  use TasksmanagerWeb, :controller
  import Ecto.Query, warn: false
  alias Tasksmanager.Repo
  alias Tasksmanager.Accounts
  alias Tasksmanager.Accounts.User
  alias Tasksmanager.Tracker
  alias Tasksmanager.Tracker.Task
  alias Tasksmanager.Tracker.TimeBlock

  def findusers() do
    query = from(u in User, select: {u.email,u.id} , where: u.select_manager_id == @current_user)
    users = Repo.all(query)
  end

  def index(conn, _params) do
    IO.inspect("Inside index ooo")
    users = findusers()
    IO.inspect("Inside index ooo")
    tasks = Tracker.list_tasks()
    changeset = Tracker.change_task(%Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset, users: users
  end



  def new(conn, _params) do
    IO.inspect("Inside new ooo")
    changeset = Tracker.change_task(%Task{})
    current_user = conn.assigns.current_user.id
    IO.inspect("inside new")
    IO.inspect(current_user)
    query = from(u in User, select: {u.email, u.id} , where: u.select_manager_id == ^current_user)
    users = Repo.all(query)

    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"task" => task_params}) do
    IO.inspect("Inside create")

    users = findusers()
    tasks = Tracker.list_tasks()
    case Tracker.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, tasks: tasks, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
      IO.inspect("Inside show ooo")
    task = Tracker.get_task!(id)
    query = from(t in TimeBlock, select: [t.starttime, t.endtime, t.id, t.task_id] , where: t.task_id == ^id)
    timeblocks = Repo.all(query)
    IO.inspect(timeblocks)
   render(conn, "show.html", task: task, timeblocks: timeblocks)
  end

  def edit(conn, %{"id" => id}) do
    IO.inspect("Inside edit ooo")
    task = Tracker.get_task!(id)
    changeset = Tracker.change_task(task)
    current_user = conn.assigns.current_user.id
    query = from(u in User, select: {u.email, u.id} , where: u.select_manager_id == ^current_user)
    users = Repo.all(query)
    render(conn, "edit.html", task: task, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    IO.inspect("Inside update ooo")
    task = Tracker.get_task!(id)
    users = findusers()
    case Tracker.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset, users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tracker.get_task!(id)
    {:ok, _task} = Tracker.delete_task(task)
    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: page_path(conn, :feed))
  end
end
