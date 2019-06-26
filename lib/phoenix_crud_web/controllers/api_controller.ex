defmodule PhoenixCrudWeb.ApiController do
  use PhoenixCrudWeb, :controller

  # create
  def insert(conn, %{"username" => username, "password" => password}) do
    case Mongo.insert_one(:local_database, "users", %{username: username, password: password}) do
      {:ok, _} ->
        conn |> json(%{success: true})

      _ ->
        conn |> json(%{success: false})
    end
  end

  # read
  def read(conn, _params) do
    users = Mongo.find(:local_database, "users", %{}) |> Enum.to_list()

    users =
      Enum.map(users, fn elem ->
        elem |> Map.delete("_id")
      end)

    conn |> json(users)
  end

  # update
  def update(conn, %{"username" => username, "password" => password}) do
    Mongo.update_one(:local_database, "users", %{username: username}, %{
      "$set": %{username: username, password: password}
    })

    conn |> json(%{success: true})
  end

  # delete
  def delete(conn, _params) do
    username = conn.query_params["username"]
    case Mongo.delete_one(:local_database, "users", %{username: username}) do
      {:ok, _} ->
        conn |> json(%{success: true})

      _ ->
        conn |> json(%{success: false})
    end
  end
end
