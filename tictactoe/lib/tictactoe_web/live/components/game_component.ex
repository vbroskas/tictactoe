defmodule TictactoeWeb.GameComponent do
  use TictactoeWeb, :live_component
  alias TictactoeWeb.ToggleCell
  @game_id_length 3

  def mount(socket) do
    game = Game.start_game(true)
    socket = update_game_socket_assigns(socket, game)
    {:ok, socket}
  end

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end

  def handle_event("mark", %{"cell" => cell}, socket) do
    IO.puts("YOU CLICKED: #{cell}")
    game = socket.assigns.game
    game = Game.make_move(game, String.to_atom(cell), "x", :x)
    IO.inspect(game)

    socket = update_game_socket_assigns(socket, game)

    {:noreply, socket}
  end

  defp update_game_socket_assigns(socket, game) do
    socket
    |> assign(:game, game)
    |> assign(:cells, %{
      "c1" => game.board.c1,
      "c2" => game.board.c2,
      "c3" => game.board.c3,
      "c4" => game.board.c4,
      "c5" => game.board.c5,
      "c6" => game.board.c6,
      "c7" => game.board.c7,
      "c8" => game.board.c8,
      "c9" => game.board.c9
    })
  end

  def create_temp_fake_game_id do
    :crypto.strong_rand_bytes(@game_id_length)
    |> Base.encode64()
    |> binary_part(0, @game_id_length)
  end
end
