defmodule Tortuga.Plugs.Logger do
  @moduledoc """
  A reimplementation of [Plug.Logger](https://hexdocs.pm/plug/Plug.Logger.html) from `Plug` that uses colored output and
  a custom log format.
  """

  require Logger
  alias Plug.Conn
  @behaviour Plug

  @impl true
  def init(opts), do: opts

  @impl true
  def call(conn, _opts) do
    construct_request_log(conn)
    |> Logger.info()

    start = System.monotonic_time()

    Conn.register_before_send(conn, fn conn ->
      stop = System.monotonic_time()
      diff = System.convert_time_unit(stop - start, :native, :microsecond)

      construct_response_log(conn, diff)
      |> Logger.info()

      conn
    end)
  end

  defp construct_request_log(conn) do
    [
      :color33,
      "(#{get_ip(conn)})",
      :reset,
      " ---> ",
      get_method_color(conn),
      conn.method,
      :reset,
      ?\s,
      conn.request_path
    ]
    |> Bunt.ANSI.format()
  end

  defp construct_response_log(conn, diff) do
    [
      :color33,
      "(#{get_ip(conn)})",
      :reset,
      " <--- ",
      get_status_color(conn),
      Integer.to_string(conn.status),
      :reset,
      ?\s,
      connection_type(conn),
      " in ",
      formatted_diff(diff)
    ]
    |> Bunt.ANSI.format()
  end

  defp get_method_color(conn) do
    case conn.method do
      "GET" -> :green
      "POST" -> :yellow
      "PUT" -> :color33
      "DELETE" -> :red
      "PATCH" -> :magenta
      "HEAD" -> :cyan
      "OPTIONS" -> :white
      _ -> :reset
    end
  end

  defp get_status_color(conn) do
    # Get the first digit of the status code
    case Integer.digits(conn.status) |> List.first() do
      1 -> :cyan
      2 -> :green
      3 -> :blue
      4 -> :yellow
      5 -> :red
      _ -> :reset
    end
  end

  defp formatted_diff(diff) when diff > 1000, do: [diff |> div(1000) |> Integer.to_string(), "ms"]
  defp formatted_diff(diff), do: [Integer.to_string(diff), "µs"]

  defp connection_type(%{state: :set_chunked}), do: "Chunked"
  defp connection_type(_), do: "Sent"

  defp get_ip(conn) do
    conn.remote_ip
    |> :inet.ntoa()
    |> to_string()
  end
end
