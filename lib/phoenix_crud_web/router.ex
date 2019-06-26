defmodule PhoenixCrudWeb.Router do
  use PhoenixCrudWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhoenixCrudWeb do
    pipe_through :api

    post "/create", ApiController, :insert
    get "/read", ApiController, :read
    post "/update", ApiController, :update
    get "/delete", ApiController, :delete
  end
end
