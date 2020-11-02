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
            state: :playing

  def start_game() do
    %Game{}
  end

  def make_move(%Game{} = game, cell, mark) do
    Map.put(game, cell, mark)
    |> check_game_state()
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
end
