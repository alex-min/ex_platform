defmodule ExPlatform.ActionEmail do
  @enforce_keys [:to, :title, :link_to, :link_text, :top_text, :bottom_text]
  defstruct [:to, :title, :link_to, :link_text, :top_text, :bottom_text, :footer_text]
end
