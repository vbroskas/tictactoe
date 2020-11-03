defmodule Tictactoe.Game do
  alias Tictactoe.Game

  defstruct c1: nil,
            c2: nil,
            c3: nil,
            c4: nil,
            c5: nil,
            c6: nil,
            c7: nil,
            c8: nil,
            c9: nil,
            state: :playing,
            move: :p1

  def start_game() do
    %Game{}
  end

  def make_move(%Game{move: player_move} = game, cell, mark, player) when player == player_move do
    update_player_move(game, player)
    |> Map.put(cell, mark)
    |> check_game_state()
  end

  def make_move(%Game{move: player_move} = game, _cell, _mark, player)
      when player != player_move do
    IO.puts("WRONG PLAYER TRYING TO MOVE, it's #{player_move}'s turn!")
    game
  end

  # Horizontal wins--------------------------
  def check_game_state(%{c1: mark, c2: mark, c3: mark} = game) when is_binary(mark) do
    IO.puts("Horizontal win BY: #{mark}")
    %{game | state: :won}
  end

  def check_game_state(%{c4: mark, c5: mark, c6: mark} = game) when is_binary(mark) do
    IO.puts("Horizontal win BY: #{mark}")
    %{game | state: :won}
  end

  def check_game_state(%{c7: mark, c8: mark, c9: mark} = game) when is_binary(mark) do
    IO.puts("Horizontal win BY: #{mark}")
    %{game | state: :won}
  end

  # Vertical wins--------------------------
  def check_game_state(%{c1: mark, c4: mark, c7: mark} = game) when is_binary(mark) do
    IO.puts("Vertical WIN BY: #{mark}")
    %{game | state: :won}
  end

  def check_game_state(%{c2: mark, c5: mark, c8: mark} = game) when is_binary(mark) do
    IO.puts("Vertical WIN BY: #{mark}")
    %{game | state: :won}
  end

  def check_game_state(%{c3: mark, c6: mark, c9: mark} = game) when is_binary(mark) do
    IO.puts("Vertical WIN BY: #{mark}")
    %{game | state: :won}
  end

  # Diagonal wins--------------------------
  def check_game_state(%{c1: mark, c5: mark, c9: mark} = game) when is_binary(mark) do
    IO.puts("Diagonal WIN BY: #{mark}")
    %{game | state: :won}
  end

  def check_game_state(%{c3: mark, c5: mark, c7: mark} = game) when is_binary(mark) do
    IO.puts("Diagonal WIN BY: #{mark}")
    %{game | state: :won}
  end

  def check_game_state(%{c3: mark, c5: mark, c7: mark} = game) when is_binary(mark) do
    IO.puts("Diagonal WIN BY: #{mark}")
    %{game | state: :won}
  end

  def check_game_state(game) do
    Map.values(game)
    |> Enum.member?(nil)
    |> check_if_draw(game)
  end

  def check_if_draw(true, game) do
    IO.puts("not won yet...")
    game
  end

  def check_if_draw(false, game) do
    IO.puts("DRAW!")
    %{game | state: :draw}
  end

  # player 1 just moved, it's now player 2 turn to move
  defp update_player_move(game, _player = :p1) do
    Map.put(game, :move, :p2)
  end

  # player 2 just moved, it's now player 1 turn to move
  defp update_player_move(game, _player = :p2) do
    Map.put(game, :move, :p1)
  end
end
