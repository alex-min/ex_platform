defmodule ExPlatformWeb.UserRegistrationView do
  use ExPlatformWeb, :view
  alias ExPlatformWeb.ErrorHelpers

  def render("new.json", %{changeset: changeset}),
    do: ErrorHelpers.get_errors(changeset)
end
