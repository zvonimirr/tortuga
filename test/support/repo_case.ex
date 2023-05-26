defmodule Tortuga.RepoCase do
  @moduledoc """
  An ExUnit case that starts and stops the Ecto repo.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias Tortuga.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Tortuga.RepoCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Tortuga.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Tortuga.Repo, {:shared, self()})
    end

    :ok
  end
end
