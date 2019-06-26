defmodule PhoenixCrud.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the endpoint when the application starts
      PhoenixCrudWeb.Endpoint,
      # Starts a worker by calling: PhoenixCrud.Worker.start_link(arg)
      # {PhoenixCrud.Worker, arg},
      %{
        id: Mongo,
        start: { Mongo, :start_link, [[name: :local_database, database: "phoenix_crud", pool_size: 2]] }
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixCrud.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhoenixCrudWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
