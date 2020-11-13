defmodule TictactoeWeb.ToggleCell do
  use TictactoeWeb, :live_component

  def render(assigns) do
    ~L"""
    <%= @inner_content.(state: @state) %>

    """
  end
end
