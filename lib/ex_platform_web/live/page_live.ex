defmodule ExPlatformWeb.PageLive do
  @moduledoc """
   homepage
  """
  use ExPlatformWeb, :live_view

  @impl true
  def handle_params(_param, _url, socket) do
    {:noreply, socket}
  end
end
