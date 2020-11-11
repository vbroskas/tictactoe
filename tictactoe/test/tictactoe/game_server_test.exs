defmodule Tictactoe.GameServerTest do
  use ExUnit.Case
  alias Tictactoe.GameSupervisor

  test "game starts via dynamic server" do
    {:ok, pid} = GameSupervisor.start_game_server()
    assert is_pid(pid) == true
  end

  test "make a move via GameServer" do
    {:ok, pid} = GameSupervisor.start_game_server()
    game = GenServer.call(pid, {:make_move, %{cell: :c5, mark: "x", player: :x}})
    assert game.board.c5 == "x"
    assert game.game_state == :playing
    # should be x's move because computer will automatically move after each time human does
    assert game.move == :x
    assert game.winner == nil
  end
end
