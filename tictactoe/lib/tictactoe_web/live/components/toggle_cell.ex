defmodule TictactoeWeb.ToggleCell do
  use TictactoeWeb, :live_component

  def render(assigns) do
    ~L"""
    <%= @inner_content.(active: @active) %>

    """
  end
end
