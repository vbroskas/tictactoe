defmodule GameTest do
  use ExUnit.Case
  doctest Game
  alias Game

  test "create new game struct" do
    game = Game.start_game()
    assert game.board.c1 == nil
    assert game.board.c2 == nil
    assert game.board.c3 == nil
    assert game.board.c4 == nil
    assert game.board.c5 == nil
    assert game.board.c6 == nil
    assert game.board.c7 == nil
    assert game.board.c8 == nil
    assert game.board.c9 == nil
    assert game.game_state == :playing
  end

  test "can make a move" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x", :x)
    assert game.c1 == "x"
    assert game.game_state == :playing
  end

  @doc """
  turn off comp play for this
  """
  test "horizontal win" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x", :x)
    game = Game.make_move(game, :c2, "x", :x)
    game = Game.make_move(game, :c3, "x", :x)

    assert game.game_state == :won
  end

  @doc """
  turn off comp play for this
  """
  test "vertical win" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x", :x)
    game = Game.make_move(game, :c4, "x", :x)
    game = Game.make_move(game, :c7, "x", :x)
    assert game.game_state == :won
  end

  @doc """
  turn off comp play for this
  """
  test "diagonal win" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x", :x)
    game = Game.make_move(game, :c5, "x", :x)
    game = Game.make_move(game, :c9, "x", :x)
    assert game.game_state == :won
  end

  @doc """
  turn off comp play for this
  """
  test "draw" do
    game = Game.start_game()
    game = Game.make_move(game, :c1, "x", :x)
    game = Game.make_move(game, :c2, "o", :o)
    game = Game.make_move(game, :c3, "x", :x)
    game = Game.make_move(game, :c5, "o", :o)
    game = Game.make_move(game, :c8, "x", :x)
    game = Game.make_move(game, :c4, "o", :o)
    game = Game.make_move(game, :c6, "x", :x)
    game = Game.make_move(game, :c9, "o", :o)
    game = Game.make_move(game, :c7, "x", :x)
    assert game.game_state == :draw
  end

  test "player can't move when it's not their turn" do
    game = Game.start_game()
    assert game.move == :x
    game = Game.make_move(game, :c1, "o", :o)
    assert game.move == :p1
    assert game.c1 == nil
  end
end
