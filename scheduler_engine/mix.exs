defmodule SchedulerEngine.MixProject do
  use Mix.Project

  def project do
    [
      app: :scheduler_engine,
      version: "0.1.0",
      elixirc_paths: ["lib", "proto"],
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Scheduler.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:grpc, github: "elixir-grpc/grpc"},
      {:protobuf, "~> 0.10"},
      {:uuid, "~> 1.1"}
    ]
  end
end
