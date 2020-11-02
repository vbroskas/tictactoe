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
    assert game.state == :playing
  end

  test "can make a move" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x")
    game = Game.make_move(game, :c2, "o")
    game = Game.make_move(game, :c5, "x")
    game = Game.make_move(game, :c9, "o")
    assert game.c1 == "x"
    assert game.c5 == "x"
    assert game.c2 == "o"
    assert game.c9 == "o"
    assert game.state == :playing
  end

  test "horizontal win" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x")
    game = Game.make_move(game, :c2, "x")
    game = Game.make_move(game, :c3, "x")
    assert game.state == :won
  end

  test "vertical win" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x")
    game = Game.make_move(game, :c4, "x")
    game = Game.make_move(game, :c7, "x")
    assert game.state == :won
  end

  test "diagonal win" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x")
    game = Game.make_move(game, :c5, "x")
    game = Game.make_move(game, :c9, "x")
    assert game.state == :won
  end

  test "draw" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x")
    game = Game.make_move(game, :c2, "o")
    game = Game.make_move(game, :c3, "x")
    game = Game.make_move(game, :c4, "o")
    game = Game.make_move(game, :c5, "x")
    game = Game.make_move(game, :c6, "x")
    game = Game.make_move(game, :c7, "o")
    game = Game.make_move(game, :c8, "x")
    game = Game.make_move(game, :c9, "o")
    assert game.state == :draw
  end
end
