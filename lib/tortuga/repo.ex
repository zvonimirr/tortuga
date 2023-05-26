defmodule Tortuga.Repo do
  @moduledoc """
  The default Ecto repo for the CMS.
  """

  use Ecto.Repo,
    otp_app: :tortuga,
    adapter: Ecto.Adapters.Postgres
end
