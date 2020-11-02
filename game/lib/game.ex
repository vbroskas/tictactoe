defmodule Game do
  alias Tictactoe.Game

  @moduledoc """
  Api for `Game`.
  """

  defdelegate start_game(), to: Game
  defdelegate make_move(game, cell, mark), to: Game
end
