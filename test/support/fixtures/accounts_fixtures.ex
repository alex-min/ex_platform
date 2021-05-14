defmodule ExPlatform.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ExPlatform.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> ExPlatform.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, %Bamboo.Email{} = captured} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token, _] = String.split(captured.text_body, "[TOKEN]")
    token
  end
end
