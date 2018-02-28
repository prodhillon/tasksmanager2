defmodule TasksmanagerWeb.UserController do
  use TasksmanagerWeb, :controller
  import Ecto.Query, warn: false
  alias Tasksmanager.Repo
  alias Tasksmanager.Accounts
  alias Tasksmanager.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    query = from(u in User, select: {u.email,u.id})
    allusers = Repo.all(query)
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset, allusers: allusers)
  end

  def create(conn, %{"user" => user_params}) do
    query = from(u in User, select: {u.email,u.id})
    allusers = Repo.all(query)
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, allusers: allusers)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    IO.inspect("inside show")
    IO.inspect(user)
    query = from(u in User, select: [u.email,u.name] , where: u.select_manager_id == ^user.id)
    underlings = Repo.all(query)
    IO.inspect(underlings)
    render(conn, "show.html", user: user, underlings: underlings)
  end

  def edit(conn, %{"id" => id}) do
    query = from(u in User, select: {u.email,u.id})
    allusers = Repo.all(query)
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset, allusers: allusers)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
