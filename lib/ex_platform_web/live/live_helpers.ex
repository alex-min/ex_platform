defmodule ExPlatformWeb.LiveHelpers do
  @moduledoc """
    A collection of the live helpers used in the live templates.
  """
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `ExPlatformWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, ExPlatformWeb.UserLive.FormComponent,
        id: @user.id || :new,
        action: @live_action,
        user: @user,
        return_to: Routes.user_index_path(@socket, :index) %>
  """
  def live_modal(component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]

    live_component(ExPlatformWeb.ModalComponent, modal_opts)
  end

  def get_timezone(socket, session) do
    if Phoenix.LiveView.connected?(socket) do
      case Phoenix.LiveView.get_connect_params(socket) do
        %{"timezone" => timezone} -> timezone
        _ -> session["timezone"] || 0
      end
    else
      session["timezone"] || 0
    end
  end

  def to_datestring(date, _locale, _timezone) when date == nil or date == "" do
    ""
  end

  def to_datestring(date, locale, timezone) when is_binary(date) do
    {:ok, parsed_date, _} = DateTime.from_iso8601(date)

    {:ok, str} =
      ExPlatform.Cldr.DateTime.to_string(parsed_date |> DateTime.add(60 * 60 * timezone, :second),
        locale: locale
      )

    str
  end

  @spec to_datestring(DateTime.t() | String.t(), String.t(), integer()) :: String.t()
  def to_datestring(date, locale, timezone) do
    {:ok, str} =
      ExPlatform.Cldr.DateTime.to_string(date |> DateTime.add(60 * 60 * timezone, :second),
        locale: locale
      )

    str
  end
end
