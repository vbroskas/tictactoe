defmodule Tictactoe.GameServer do
  use GenServer, restart: :transient

  def start_link(game_id) do
    GenServer.start_link(__MODULE__, [], name: create_name(game_id))
  end

  def init(_) do
    game = Game.start_game(true)
    {:ok, game}
  end

  def make_move(%{game_id: id, cell: _cell, mark: _mark, player: _player} = move) do
    GenServer.call({:via, Registry, {GameRegistry, id}}, {:make_move, move})
  end

  def handle_call({:make_move, move}, _from, game) do
    game = Game.make_move(game, move.cell, move.mark, move.player)
    {:reply, game, game}
  end

  defp create_name(game_id) do
    {:via, Registry, {GameRegistry, "#{game_id}"}}
  end
end
