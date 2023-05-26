defmodule Tortuga.Router do
  @moduledoc """
  The CMS router.
  It serves as the entry point for all requests.
  """

  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match _ do
    send_resp(conn, 404, "not found")
  end
end
