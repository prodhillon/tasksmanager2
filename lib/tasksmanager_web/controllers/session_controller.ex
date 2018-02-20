defmodule TasksmanagerWeb.SessionController do
  use TasksmanagerWeb, :controller

  alias Tasksmanager.Accounts
  alias Tasksmanager.Accounts.User

  def create(conn, %{"email" => email}) do
    user = Accounts.get_user_by_email(email)
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome #{user.name}")
      |> redirect(to: page_path(conn, :feed))
    else
      conn
      |> put_flash(:error, "User not found. Please register if you are a new user.")
      |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out")
    |> redirect(to: page_path(conn, :index))
  end
end
