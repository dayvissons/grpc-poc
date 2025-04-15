defmodule Scheduler.ScheduleRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.1", syntax: :proto3

  field :id, 1, type: :string
  field :task_name, 2, type: :string, json_name: "taskName"
  field :execute_at, 3, type: :string, json_name: "executeAt"
end

defmodule Scheduler.ScheduleResponse do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.1", syntax: :proto3

  field :status, 1, type: :string
  field :message, 2, type: :string
end

defmodule Scheduler.Task do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.1", syntax: :proto3

  field :id, 1, type: :string
  field :task_name, 2, type: :string, json_name: "taskName"
  field :execute_at, 3, type: :string, json_name: "executeAt"
end

defmodule Scheduler.TaskList do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.1", syntax: :proto3

  field :tasks, 1, repeated: true, type: Scheduler.Task
end

defmodule Scheduler.Empty do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.1", syntax: :proto3
end

defmodule Scheduler.TaskScheduler.Service do
  @moduledoc false

  use GRPC.Service, name: "scheduler.TaskScheduler", protoc_gen_elixir_version: "0.14.1"

  rpc :ScheduleTask, Scheduler.ScheduleRequest, Scheduler.ScheduleResponse

  rpc :ListTasks, Scheduler.Empty, Scheduler.TaskList
end

defmodule Scheduler.TaskScheduler.Stub do
  @moduledoc false

  use GRPC.Stub, service: Scheduler.TaskScheduler.Service
end
