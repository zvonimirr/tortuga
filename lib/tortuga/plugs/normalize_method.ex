defmodule Tortuga.Plugs.NormalizeMethod do
  @moduledoc """
  A plug that normalizes the HTTP method to uppercase.
  """

  @behaviour Plug

  @impl true
  def init(opts), do: opts

  @impl true
  def call(conn, _opts) do
    conn
    |> normalize_method()
  end

  defp normalize_method(conn) do
    %{conn | method: String.upcase(conn.method)}
  end
end
