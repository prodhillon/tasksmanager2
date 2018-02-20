defmodule TasksmanagerWeb.TaskController do
  use TasksmanagerWeb, :controller
  import Ecto.Query, warn: false
  alias Tasksmanager.Repo
  alias Tasksmanager.Accounts
  alias Tasksmanager.Accounts.User
  alias Tasksmanager.Tracker
  alias Tasksmanager.Tracker.Task

  def findusers() do
    query = from(u in User, select: {u.email,u.id})
    users = Repo.all(query)
  end

  def index(conn, _params) do
    users = findusers()
    tasks = Tracker.list_tasks()
    changeset = Tracker.change_task(%Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset, users: users
  end


  def new(conn, _params) do
    changeset = Tracker.change_task(%Task{})
    users = findusers()
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
    task = Tracker.get_task!(id)
   render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tracker.get_task!(id)
    changeset = Tracker.change_task(task)
    users = findusers()
    render(conn, "edit.html", task: task, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
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
