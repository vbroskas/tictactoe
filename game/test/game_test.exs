defmodule GameTest do
  use ExUnit.Case
  doctest Game
  alias Game

  test "create new game struct" do
    game = Game.start_game()
    assert game.c1 == nil
    assert game.c2 == nil
    assert game.c3 == nil
    assert game.c4 == nil
    assert game.c5 == nil
    assert game.c6 == nil
    assert game.c7 == nil
    assert game.c8 == nil
    assert game.c9 == nil
    assert game.game_state == :playing
  end

  test "can make a move" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x", :p1)
    game = Game.make_move(game, :c2, "o", :p2)
    game = Game.make_move(game, :c5, "x", :p1)
    game = Game.make_move(game, :c9, "o", :p2)
    assert game.c1 == "x"
    assert game.c5 == "x"
    assert game.c2 == "o"
    assert game.c9 == "o"
    assert game.game_state == :playing
  end

  test "horizontal win" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x", :p1)
    game = Game.make_move(game, :c4, "x", :p2)
    game = Game.make_move(game, :c2, "x", :p1)
    game = Game.make_move(game, :c5, "x", :p2)
    game = Game.make_move(game, :c3, "x", :p1)
    assert game.game_state == :won
  end

  test "vertical win" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x", :p1)
    game = Game.make_move(game, :c3, "o", :p2)
    game = Game.make_move(game, :c4, "x", :p1)
    game = Game.make_move(game, :c6, "o", :p2)
    game = Game.make_move(game, :c7, "x", :p1)
    assert game.game_state == :won
  end

  test "diagonal win" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x", :p1)
    game = Game.make_move(game, :c2, "o", :p2)
    game = Game.make_move(game, :c5, "x", :p1)
    game = Game.make_move(game, :c3, "o", :p2)
    game = Game.make_move(game, :c9, "x", :p1)
    assert game.game_state == :won
  end

  test "draw" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x", :p1)
    game = Game.make_move(game, :c2, "o", :p2)
    game = Game.make_move(game, :c3, "x", :p1)
    game = Game.make_move(game, :c5, "o", :p2)
    game = Game.make_move(game, :c8, "x", :p1)
    game = Game.make_move(game, :c4, "o", :p2)
    game = Game.make_move(game, :c6, "x", :p1)
    game = Game.make_move(game, :c9, "o", :p2)
    game = Game.make_move(game, :c7, "x", :p1)
    assert game.game_state == :draw
  end

  test "player can't move when it's not their turn" do
    game = Game.start_game()
    assert game.move == :p1
    game = Game.make_move(game, :c1, "o", :p2)
    assert game.move == :p1
    assert game.c1 == nil
  end
end
