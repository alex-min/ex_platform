defmodule ExPlatform.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @derive {Phoenix.Param, key: :id}

      def count do
        ExPlatform.Repo.aggregate(__MODULE__, :count, :id)
      end

      def all() do
        __MODULE__ |> ExPlatform.Repo.all()
      end

      def get(id) do
        ExPlatform.Repo.get(__MODULE__, id)
      end

      def first do
        __MODULE__ |> Ecto.Query.first() |> ExPlatform.Repo.one()
      end

      def last do
        __MODULE__ |> Ecto.Query.last() |> ExPlatform.Repo.one()
      end
    end
  end
end
