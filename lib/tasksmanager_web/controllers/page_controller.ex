defmodule TasksmanagerWeb.PageController do
  use TasksmanagerWeb, :controller
  import Ecto.Query, warn: false
  alias Tasksmanager.Repo

  alias Tasksmanager.Accounts
  alias Tasksmanager.Accounts.User
  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    query = from(u in User, select: {u.name, u.id})
    users = Repo.all(query)
    tasks = Tasksmanager.Tracker.list_tasks()
    changeset = Tasksmanager.Tracker.change_task(%Tasksmanager.Tracker.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset, users: users
  end

end
