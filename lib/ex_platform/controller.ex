defmodule ExPlatform.Controller do
  defmacro __using__(_) do
    quote do
      import Phoenix.Controller

      def requested_json?(conn), do: accepts_json?(conn) || content_type_json?(conn)

      @spec content_type_json?(Plug.Conn.t()) :: boolean()
      def content_type_json?(conn) do
        case Plug.Conn.get_req_header(conn, "content-type") do
          ["application/json;" <> _] -> true
          ["application/json"] -> true
          _ -> false
        end
      end

      @spec accepts_json?(Plug.Conn.t()) :: boolean()
      def accepts_json?(conn) do
        case Plug.Conn.get_req_header(conn, "accept") do
          ["application/json;" <> _] -> true
          ["application/json"] -> true
          _ -> false
        end
      end
    end
  end
end
