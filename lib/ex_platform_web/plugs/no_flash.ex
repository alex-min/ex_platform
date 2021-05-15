defmodule ExPlatformWeb.Plugs.NoFlash do
  @moduledoc """
    A plug to stub the flash methods, useful to run when using json apis.
  """
  def init(opts), do: opts

  def call(%Plug.Conn{private: private} = conn, _opts) do
    %{conn | private: Map.put(private, :phoenix_flash, %{})}
  end
end
