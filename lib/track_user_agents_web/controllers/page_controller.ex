defmodule TrackUserAgentsWeb.PageController do
  use TrackUserAgentsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
