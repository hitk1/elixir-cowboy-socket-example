defmodule Websocket.Sockets do
  import Logger
  @behaviour :cowboy_websocket

  def init(req, state) do
    {:cowboy_websocket, req, state}
  end

  # @timeout 60000 # terminate if no activity for one minute

  #Called on websocket connection initialization.
  def websocket_init(state) do
    # state = %{}
    Logger.info("Socket iniciado")
    {:ok, state}
  end

  # Handle 'ping' messages from the browser - reply
  def websocket_handle({:text, "ping"}, state) do
    {:reply, {:text, "pong"}, state}
  end

  # Handle other messages from the browser - don't reply
  def websocket_handle({:text, message}, req, state) do
    IO.puts(message)
    {:ok, req, state}
  end

  def websocket_info(_code_info, state) do
    {:reply, {:text, "testado"}, state}
  end
  # # Format and forward elixir messages to client
  # def websocket_info(message, req, state) do
  #   {:reply, {:text, message}, req, state}
  # end

  # No matter why we terminate, remove all of this pids subscriptions
  def websocket_terminate(_reason, _req, _state) do
    :ok
  end
end
