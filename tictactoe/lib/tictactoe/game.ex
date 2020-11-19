defmodule Tictactoe.Game do
  alias Tictactoe.GameCore

  @moduledoc """
  Api for Game Module.
  """

  defdelegate start_game(human_moves_first), to: GameCore

  defdelegate make_move(game, cell, mark, player), to: GameCore
end
