defmodule Game do
  @moduledoc """
  Documentation for `Game`.
  """
  defstruct c1: nil, c2: nil, c3: nil, c4: nil, c5: nil, c6: nil, c7: nil, c8: nil, c9: nil

  def start_game() do
    %Game{}
  end

  def make_move(%Game{} = game, cell, mark) do
    Map.put(game, cell, mark)
    |> check_game_state()
  end

  # Horizontal wins--------------------------
  def check_game_state(%{c1: mark, c2: mark, c3: mark} = _game) when is_binary(mark) do
    IO.puts("Horizontal win BY: #{mark}")
  end

  def check_game_state(%{c4: mark, c5: mark, c6: mark} = _game) when is_binary(mark) do
    IO.puts("Horizontal win BY: #{mark}")
  end

  def check_game_state(%{c7: mark, c8: mark, c9: mark} = _game) when is_binary(mark) do
    IO.puts("Horizontal win BY: #{mark}")
  end

  # Vertical wins--------------------------
  def check_game_state(%{c1: mark, c4: mark, c7: mark} = _game) when is_binary(mark) do
    IO.puts("Vertical WIN BY: #{mark}")
  end

  def check_game_state(%{c2: mark, c5: mark, c8: mark} = _game) when is_binary(mark) do
    IO.puts("Vertical WIN BY: #{mark}")
  end

  def check_game_state(%{c3: mark, c6: mark, c9: mark} = _game) when is_binary(mark) do
    IO.puts("Vertical WIN BY: #{mark}")
  end

  # Diagonal wins--------------------------
  def check_game_state(%{c1: mark, c5: mark, c9: mark} = _game) when is_binary(mark) do
    IO.puts("Diagonal WIN BY: #{mark}")
  end

  def check_game_state(%{c3: mark, c5: mark, c7: mark} = _game) when is_binary(mark) do
    IO.puts("Diagonal WIN BY: #{mark}")
  end

  def check_game_state(game) do
    IO.puts("not won yet...")
    game
  end
end
