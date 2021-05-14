defmodule ExPlatformWeb.Plugs.NoFlash do
  def init(opts), do: opts

  def call(%Plug.Conn{private: private} = conn, _opts) do
    %{conn | private: Map.put(private, :phoenix_flash, %{})}
  end
end
