defmodule Tortuga.Router do
  @moduledoc """
  The CMS router.
  It serves as the entry point for all requests.
  """

  use Plug.Router

  plug(Tortuga.Plugs.NormalizeMethod)
  plug(Tortuga.Plugs.Logger)
  plug(:match)
  plug(:dispatch)

  match _ do
    send_resp(conn, 404, "not found")
  end
end
