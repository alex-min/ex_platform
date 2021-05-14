defmodule ExPlatformWeb.UserRegistrationControllerTest do
  use ExPlatformWeb.ConnCase, async: true
  use Bamboo.Test

  import ExPlatform.AccountsFixtures

  describe "GET /users/register" do
    test "renders registration page", %{conn: conn} do
      conn = get(conn, Routes.user_registration_path(conn, :new))
      response = html_response(conn, 200)
      assert response =~ "Register your account"
      assert response =~ "Sign in to your account</a>"
      assert response =~ "Register</button>"
    end

    test "redirects if already logged in", %{conn: conn} do
      conn = conn |> log_in_user(user_fixture()) |> get(Routes.user_registration_path(conn, :new))
      assert redirected_to(conn) == "/"
    end
  end

  describe "POST /users/register" do
    @tag :capture_log
    test "creates account and logs the user in", %{conn: conn} do
      email = unique_user_email()

      conn =
        post(conn, Routes.user_registration_path(conn, :create), %{
          "user" => %{"email" => email, "password" => valid_user_password()}
        })

      assert get_session(conn, :user_token)
      assert redirected_to(conn) =~ "/"

      # Now do a logged in request and assert on the menu
      conn = get(conn, "/")
      response = html_response(conn, 200)
      assert response =~ "#{email}</a>"
      assert response =~ "Log out</a>"

      assert_delivered_email_matches(%{to: user_email, text_body: text_body})
      assert user_email == [nil: email]
      assert text_body =~ "/users/confirm/"
    end

    test "render errors for invalid data", %{conn: conn} do
      conn =
        post(conn, Routes.user_registration_path(conn, :create), %{
          "user" => %{"email" => "with spaces", "password" => "short"}
        })

      response = html_response(conn, 400)
      assert response =~ "Register your account"
      assert response =~ "must have the @ sign and no spaces"
      assert response =~ "should be at least 6 character"
    end

    test "registers with json", %{conn: conn} do
      email = unique_user_email()

      conn =
        conn
        |> accepts_json
        |> post(Routes.api_user_registration_path(conn, :create), %{
          "user" => %{"email" => email, "password" => valid_user_password()}
        })

      assert json_response(conn, 200) == %{"status" => "ok"}
    end

    test "render errors for json api", %{conn: conn} do
      conn =
        conn
        |> accepts_json
        |> post(Routes.api_user_registration_path(conn, :create), %{
          "user" => %{"email" => "with spaces", "password" => "short"}
        })

      assert json_response(conn, 400) == %{
               "email" => ["must have the @ sign and no spaces"],
               "password" => ["should be at least 6 character(s)"]
             }
    end
  end
end
