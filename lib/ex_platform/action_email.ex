defmodule ExPlatform.ActionEmail do
  @moduledoc """
   An action, email to send using the action_email template
  """
  @enforce_keys [:to, :title, :link_to, :link_text, :top_text, :bottom_text]
  defstruct [:to, :title, :link_to, :link_text, :top_text, :bottom_text, :footer_text]
end
