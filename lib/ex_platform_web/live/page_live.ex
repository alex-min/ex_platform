defmodule ExPlatformWeb.PageLive do
  @moduledoc """
   homepage
  """
  use ExPlatformWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_param, _url, socket) do
    {:noreply, socket}
  end
end
