defmodule TasksmanagerWeb.PageController do
  use TasksmanagerWeb, :controller
  import Ecto.Query, warn: false
  alias Tasksmanager.Repo

  alias Tasksmanager.Accounts
  alias Tasksmanager.Accounts.User
  alias Tasksmanager.Tracker
  alias Tasksmanager.Tracker.Task
  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    IO.inspect("Inside page")
    query = from(u in User, select: {u.name, u.id})
    users = Repo.all(query)

    current_user = conn.assigns.current_user.id
    query = from(u in User, select: u.id , where: u.select_manager_id == ^current_user)
    users = Repo.all(query)
    querytasks = from(t in Task,join: u in User, on: u.id == t.user_id, select: [t.title,t.description,t.completed,u.name] , where: t.user_id in ^users)
    underlings_tasks = Repo.all(querytasks)
    IO.inspect(underlings_tasks)

    tasks = Tasksmanager.Tracker.list_tasks()
    current_user = conn.assigns[:current_user]

    timeblocks = Tasksmanager.Tracker.timeblocks_map_for(current_user.id)

    changeset = Tasksmanager.Tracker.change_task(%Tasksmanager.Tracker.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset, users: users, underlings_tasks: underlings_tasks ,timeblocks: timeblocks
  end

end
