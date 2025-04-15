defmodule Scheduler.Server do
  use GRPC.Server, service: Scheduler.TaskScheduler.Service

  def schedule_task(request, _stream) do
    %Scheduler.ScheduleRequest{id: id, task_name: name, execute_at: time} = request

    case Scheduler.TaskManager.schedule_task(%{id: id, task_name: name, execute_at: time}) do
      :ok ->
        %Scheduler.ScheduleResponse{
          status: "ok",
          message: "Tarefa #{name} agendada para #{time}"
        }
    end
  end

  def list_tasks(_empty, _stream) do
    tasks = Scheduler.TaskManager.list_tasks()

    %Scheduler.TaskList{
      tasks:
        Enum.map(tasks, fn t ->
          struct(Scheduler.Task, t)
        end)
    }
  end
end
