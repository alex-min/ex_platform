defmodule ExPlatform.ActionEmail do
  @moduledoc """
   An action, email to send using the action_email template
  """
  @enforce_keys [:to, :title, :link_to, :link_text, :top_text, :bottom_text]
  defstruct [:to, :title, :link_to, :link_text, :top_text, :bottom_text, :footer_text]

  @type t() :: %__MODULE__{
          to: String.t(),
          title: String.t(),
          link_to: String.t(),
          link_text: String.t(),
          top_text: String.t(),
          bottom_text: String.t(),
          footer_text: String.t() | nil
        }
end
