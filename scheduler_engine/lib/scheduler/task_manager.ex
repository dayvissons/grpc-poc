defmodule Scheduler.TaskManager do
  use GenServer

  def start_link(_), do: GenServer.start_link(__MODULE__, %{}, name: __MODULE__)

  def schedule_task(%{id: id, task_name: name, execute_at: time_iso}) do
    execute_at = DateTime.from_iso8601(time_iso) |> elem(1)
    now = DateTime.utc_now()
    diff_ms = DateTime.diff(execute_at, now, :millisecond)

    if diff_ms > 0 do
      Process.send_after(self(), {:execute, id}, diff_ms)
    else
      send(self(), {:execute, id})
    end

    GenServer.call(__MODULE__, {:add_task, id, name, time_iso})
  end

  def list_tasks, do: GenServer.call(__MODULE__, :list)

  ## Server

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:add_task, id, name, time}, _from, state) do
    task = %{id: id, task_name: name, execute_at: time}
    {:reply, :ok, Map.put(state, id, task)}
  end

  def handle_call(:list, _from, state) do
    {:reply, Map.values(state), state}
  end

  def handle_info({:execute, id}, state) do
    case Map.get(state, id) do
      nil ->
        IO.puts("Tarefa #{id} não encontrada.")

      %{task_name: name} ->
        IO.puts("Executando tarefa #{id}: #{name}")
    end

    {:noreply, Map.delete(state, id)}
  end
end
