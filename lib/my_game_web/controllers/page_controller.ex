defmodule MyGameWeb.PageController do
  use MyGameWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
