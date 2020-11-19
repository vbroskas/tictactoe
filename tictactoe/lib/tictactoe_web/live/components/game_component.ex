defmodule TictactoeWeb.GameComponent do
  use TictactoeWeb, :live_component
  alias TictactoeWeb.ToggleCell
  alias Tictactoe.Game

  def mount(socket) do
    game = Game.start_game(true)

    socket =
      socket
      |> assign(human_moves_first: true, display_modal: false)
      |> update_game_socket_assigns(game)

    {:ok, socket}
  end

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end

  def handle_event("mark", %{"cell" => cell}, socket) do
    game = socket.assigns.game
    game = Game.make_move(game, String.to_atom(cell), "X", :x)
    socket = process_move(game, socket)

    {:noreply, socket}
  end

  def handle_event("comp_moves_first", _params, socket) do
    game = Game.start_game(false)

    socket =
      socket
      |> assign(human_moves_first: false)
      |> update_game_socket_assigns(game)

    {:noreply, socket}
  end

  def handle_event("human_moves_first", _params, socket) do
    game = Game.start_game(true)

    socket =
      socket
      |> assign(human_moves_first: true)
      |> update_game_socket_assigns(game)

    {:noreply, socket}
  end

  def handle_event("start_new_game", _params, socket) do
    IO.inspect(socket.assigns)
    game = Game.start_game(socket.assigns.human_moves_first)

    socket =
      socket
      |> assign(display_modal: false)
      |> update_game_socket_assigns(game)

    {:noreply, socket}
  end

  defp update_game_socket_assigns(socket, game) do
    socket
    |> assign(
      game: game,
      cells: %{
        c1: game.board.c1,
        c2: game.board.c2,
        c3: game.board.c3,
        c4: game.board.c4,
        c5: game.board.c5,
        c6: game.board.c6,
        c7: game.board.c7,
        c8: game.board.c8,
        c9: game.board.c9
      }
    )
  end

  defp process_move(%{game_state: state} = game, socket) when state in [:won, :draw] do
    socket
    |> assign(display_modal: true)
    |> update_game_socket_assigns(game)
  end

  defp process_move(game, socket) do
    socket
    |> update_game_socket_assigns(game)
  end
end
