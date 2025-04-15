defmodule Scheduler.Application do
  use Application

  def start(_type, _args) do
    # Definindo os filhos que serão supervisionados
    children = [
      # Inicia o GenServer com o estado inicial vazio
      {Scheduler.TaskManager, %{}},
      # O servidor gRPC
      {GRPC.Server.Supervisor, endpoint: Scheduler.Server, port: 50051, start_server: true}
    ]

    # Inicia o supervisor com a estratégia :one_for_one
    opts = [strategy: :one_for_one, name: Scheduler.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
