defmodule Tortuga.Plugs.NormalizeMethod do
  @moduledoc """
  A plug that normalizes the HTTP method to uppercase, as well as
  returning a 405 Method Not Allowed response if the method is
  something weird.
  """

  require Logger
  import Plug.Conn, only: [put_resp_header: 3, send_resp: 3, halt: 1]
  @behaviour Plug

  @impl true
  def init(opts), do: opts

  @impl true
  def call(conn, _opts) do
    conn
    |> normalize_method()
  end

  defp normalize_method(conn) do
    method = String.upcase(conn.method)

    # Check if the method isn't something weird.
    if method in ["GET", "POST", "PUT", "PATCH", "DELETE", "HEAD", "OPTIONS"] do
      %{conn | method: method}
    else
      # Return a 405 Method Not Allowed response.
      log_invalid_method(conn)

      conn
      |> put_resp_header("allow", "GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS")
      |> send_resp(:method_not_allowed, "Invalid method: #{method}")
      |> halt()
    end
  end

  defp log_invalid_method(conn) do
    ip = conn.remote_ip |> :inet.ntoa() |> to_string()

    [
      :color33,
      "(#{ip})",
      :reset,
      " ---> ",
      :color31,
      "INVALID METHOD ",
      :yellow,
      "'#{conn.method}'"
    ]
    |> Bunt.ANSI.format()
    |> Logger.warn()
  end
end
