defmodule GameTest do
  use ExUnit.Case
  doctest Game
  alias Game

  @doc """
  Turn OFF comp smart play for these tests
  """

  test "create new game struct" do
    game = Game.start_game(true)
    assert game.board.c1 == nil
    assert game.board.c2 == nil
    assert game.board.c3 == nil
    assert game.board.c4 == nil
    assert game.board.c5 == nil
    assert game.board.c6 == nil
    assert game.board.c7 == nil
    assert game.board.c8 == nil
    assert game.board.c9 == nil
    assert game.winner == nil
    assert game.move == :x
    assert game.game_state == :playing
  end

  test "can make a move" do
    game = Game.start_game(true)
    game = Game.make_move(game, :c1, "x", :x)
    assert game.board.c1 == "x"
    assert game.game_state == :playing
  end

  @doc """
  turn off comp play for this
  """
  test "horizontal win" do
    game = Game.start_game(true)
    game = Game.make_move(game, :c1, "x", :x)
    game = Game.make_move(game, :c7, "o", :o)
    game = Game.make_move(game, :c2, "x", :x)
    game = Game.make_move(game, :c8, "o", :o)
    game = Game.make_move(game, :c3, "x", :x)

    assert game.game_state == :won
    assert game.winner == "x"
  end

  @doc """
  turn off comp play for this
  """
  test "vertical win" do
    game = Game.start_game(true)
    game = Game.make_move(game, :c1, "x", :x)
    game = Game.make_move(game, :c3, "o", :o)
    game = Game.make_move(game, :c4, "x", :x)
    game = Game.make_move(game, :c6, "o", :o)
    game = Game.make_move(game, :c7, "x", :x)
    assert game.game_state == :won
    assert game.winner == "x"
  end

  @doc """
  turn off comp play for this
  """
  test "diagonal win" do
    game = Game.start_game(true)
    game = Game.make_move(game, :c1, "x", :x)
    game = Game.make_move(game, :c4, "o", :o)
    game = Game.make_move(game, :c5, "x", :x)
    game = Game.make_move(game, :c7, "o", :o)
    game = Game.make_move(game, :c9, "x", :x)
    assert game.game_state == :won
    assert game.winner == "x"
  end

  @doc """
  turn off comp play for this
  """
  test "draw" do
    game = Game.start_game(true)
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
    assert game.winner == "draw"
  end

  test "player can't move when it's not their turn" do
    game = Game.start_game(true)
    assert game.move == :x
    game = Game.make_move(game, :c1, "o", :o)
    assert game.move == :x
    assert game.board.c1 == nil
  end

  @doc """
  Turn ON comp smart play for below tests, and COMMENT OUT all above tests
  """

  test "comp will win in 3 moves if human plays poorly--human goes first -- first run" do
    game = Game.start_game(true)
    game = Game.make_move(game, :c5, "x", :x)
    game = Game.make_move(game, :c7, "x", :x)
    game = Game.make_move(game, :c8, "x", :x)
    assert game.game_state == :won
    assert game.winner == "o"
  end

  test "comp will win in 3 moves if human plays poorly--human goes first -- second run" do
    game = Game.start_game(true)
    game = Game.make_move(game, :c1, "x", :x)
    game = Game.make_move(game, :c9, "x", :x)
    game = Game.make_move(game, :c7, "x", :x)
    assert game.game_state == :won
    assert game.winner == "o"
  end

  test "comp will win in 3 moves if human plays poorly--comp goes first -- first run" do
    game = Game.start_game(false)
    game = Game.make_move(game, :c5, "x", :x)
    game = Game.make_move(game, :c7, "x", :x)
    assert game.game_state == :won
    assert game.winner == "o"
  end

  test "comp will win in 3 moves if human plays poorly--comp goes first -- second run" do
    game = Game.start_game(false)
    game = Game.make_move(game, :c7, "x", :x)
    game = Game.make_move(game, :c9, "x", :x)
    assert game.game_state == :won
    assert game.winner == "o"
  end
end
