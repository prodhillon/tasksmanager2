defmodule Tasksmanager.TrackerTest do
  use Tasksmanager.DataCase

  alias Tasksmanager.Tracker

  describe "tasks" do
    alias Tasksmanager.Tracker.Task

    @valid_attrs %{completed: "some completed", description: "some description", timespent: 42, title: "some title"}
    @update_attrs %{completed: "some updated completed", description: "some updated description", timespent: 43, title: "some updated title"}
    @invalid_attrs %{completed: nil, description: nil, timespent: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Tracker.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Tracker.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Tracker.create_task(@valid_attrs)
      assert task.completed == "some completed"
      assert task.description == "some description"
      assert task.timespent == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Tracker.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completed == "some updated completed"
      assert task.description == "some updated description"
      assert task.timespent == 43
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_task(task, @invalid_attrs)
      assert task == Tracker.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Tracker.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Tracker.change_task(task)
    end
  end

  describe "timeblocks" do
    alias Tasksmanager.Tracker.TimeBlock

    @valid_attrs %{endtime: ~T[14:00:00.000000], starttime: ~T[14:00:00.000000]}
    @update_attrs %{endtime: ~T[15:01:01.000000], starttime: ~T[15:01:01.000000]}
    @invalid_attrs %{endtime: nil, starttime: nil}

    def time_block_fixture(attrs \\ %{}) do
      {:ok, time_block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_time_block()

      time_block
    end

    test "list_timeblocks/0 returns all timeblocks" do
      time_block = time_block_fixture()
      assert Tracker.list_timeblocks() == [time_block]
    end

    test "get_time_block!/1 returns the time_block with given id" do
      time_block = time_block_fixture()
      assert Tracker.get_time_block!(time_block.id) == time_block
    end

    test "create_time_block/1 with valid data creates a time_block" do
      assert {:ok, %TimeBlock{} = time_block} = Tracker.create_time_block(@valid_attrs)
      assert time_block.endtime == ~T[14:00:00.000000]
      assert time_block.starttime == ~T[14:00:00.000000]
    end

    test "create_time_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_time_block(@invalid_attrs)
    end

    test "update_time_block/2 with valid data updates the time_block" do
      time_block = time_block_fixture()
      assert {:ok, time_block} = Tracker.update_time_block(time_block, @update_attrs)
      assert %TimeBlock{} = time_block
      assert time_block.endtime == ~T[15:01:01.000000]
      assert time_block.starttime == ~T[15:01:01.000000]
    end

    test "update_time_block/2 with invalid data returns error changeset" do
      time_block = time_block_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_time_block(time_block, @invalid_attrs)
      assert time_block == Tracker.get_time_block!(time_block.id)
    end

    test "delete_time_block/1 deletes the time_block" do
      time_block = time_block_fixture()
      assert {:ok, %TimeBlock{}} = Tracker.delete_time_block(time_block)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_time_block!(time_block.id) end
    end

    test "change_time_block/1 returns a time_block changeset" do
      time_block = time_block_fixture()
      assert %Ecto.Changeset{} = Tracker.change_time_block(time_block)
    end
  end
end
