defmodule Websocket.Main do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Websocket.Router, [], [
        dispatch: dispatch(),
        port: 4404
      ])
    ]

    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    [
      {:_, [
        {"/ws", Websocket.Sockets, []},
        {:_, Plug.Adapters.Cowboy.Handler, {Websocket.Router, []}}
      ]}
    ]
  end
end
