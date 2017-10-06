defmodule TrackUserAgentsWeb.Router do
  use TrackUserAgentsWeb, :router

  def unpack_events(conn, _) do
    first_key_fn = &hd(Map.keys(&1))
    cleanevents = conn.params["_json"] |>
        Enum.map(fn evt -> evt["msys"] end) |> 
        Enum.map(fn evt -> evt[first_key_fn.(evt)] end) 
      assign(conn, :events, cleanevents)
  end
 
  def filter_event_types(conn, types) do
    good_event? = &Enum.member?(types, &1["type"])
    assign(conn, :events, Enum.filter(conn.assigns[:events], good_event?))
  end

  def filter_event_fields(conn, kv) do
    pick_fields = &Map.take(&1, kv)
    assign(conn, :events, Enum.map(conn.assigns[:events], pick_fields)) 
  end

  def os_name(ua) do
    if not Map.has_key?(ua, :os) do
      "unknown"
    else
      case ua.os do
        %UAInspector.Result.OS{} -> ua.os.name
        _ -> "unknown"
      end
    end
  end

  def parse_user_agents(conn, _) do
    events = conn.assigns[:events] |>
      Enum.map(&Map.put(&1, "ua", UAInspector.parse(&1["user_agent"]))) |>
      Enum.map(&Map.put(&1, "os", os_name(&1["ua"])))
    assign(conn, :events, events)
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :webhook do
    plug :accepts, ["json"]
    plug :unpack_events
    plug :filter_event_types, ["click"]
    plug :filter_event_fields, ["user_agent"]
    plug :parse_user_agents
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/webhook", TrackUserAgentsWeb do
    pipe_through :webhook
    post "/", ApiController, :webhook
  end

  scope "/api", TrackUserAgentsWeb do
    pipe_through :api
    get "/", ApiController, :report
  end

  scope "/", TrackUserAgentsWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end
end
