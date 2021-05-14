defmodule ExPlatformWeb.UserSessionView do
  use ExPlatformWeb, :view

  def render("new.json", %{error_message: message}), do: message
end
