defmodule Game do
  alias Tictactoe.Game

  @moduledoc """
  Api for Game Module.
  """

  defdelegate start_game(human_moves_first), to: Game

  defdelegate make_move(game, cell, mark, player), to: Game
end
