defmodule Tortuga.Application do
  @moduledoc """
  The main application module for Tortuga.
  """

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Tortuga router
      {Bandit, plug: Tortuga.Router}
    ]

    opts = [strategy: :one_for_one, name: Tortuga.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
