defmodule TictactoeWeb.GameLive do
  use TictactoeWeb, :live_view

  alias TictactoeWeb.GameComponent

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <%= live_component @socket, GameComponent, id: :game %>

    """
  end
end
