defmodule Tictactoe.Game do
  alias Tictactoe.Game

  @game %{
    game_state: :playing,
    move: :x,
    winner: nil,
    board: %{
      c1: nil,
      c2: nil,
      c3: nil,
      c4: nil,
      c5: nil,
      c6: nil,
      c7: nil,
      c8: nil,
      c9: nil
    }
  }

  @scores %{
    "x" => 10,
    "o" => -10,
    "draw" => 0
  }
  def start_game() do
    @game
  end

  def make_move(%{move: player_to_move} = game, cell, mark, player)
      when player == player_to_move do
    game
    |> mark_cell(cell, mark)
    |> update_player_move(player)
    |> check_if_game_over
  end

  def make_move(%{move: player_to_move} = game, _cell, _mark, player)
      when player != player_to_move do
    IO.puts("WRONG PLAYER TRYING TO MOVE, it's #{player_to_move}'s turn!")
    game
  end

  # Mark a cell on the board
  def mark_cell(game, cell, mark) do
    # TODO put check to ensure cell is empty?
    %{game | board: Map.put(game.board, cell, mark)}
    |> check_for_win()
  end

  # game is over, return msg with result
  def check_if_game_over(%{game_state: state, winner: winner})
      when state in [:won, :draw] do
    {:game_over, winner}
  end

  # game is still playing
  def check_if_game_over(%{game_state: :playing, move: :o} = game) do
    computer_move(game)
  end

  def check_if_game_over(%{game_state: :playing, move: :x} = game) do
    game
  end

  # Horizontal wins--------------------------
  def check_for_win(%{board: %{c1: mark, c2: mark, c3: mark}} = game) when is_binary(mark) do
    %{game | game_state: :won, winner: mark}
  end

  def check_for_win(%{board: %{c4: mark, c5: mark, c6: mark}} = game)
      when is_binary(mark) do
    %{game | game_state: :won, winner: mark}
  end

  def check_for_win(%{board: %{c7: mark, c8: mark, c9: mark}} = game)
      when is_binary(mark) do
    %{game | game_state: :won, winner: mark}
  end

  # Vertical wins--------------------------
  def check_for_win(%{board: %{c1: mark, c4: mark, c7: mark}} = game)
      when is_binary(mark) do
    %{game | game_state: :won, winner: mark}
  end

  def check_for_win(%{board: %{c2: mark, c5: mark, c8: mark}} = game)
      when is_binary(mark) do
    %{game | game_state: :won, winner: mark}
  end

  def check_for_win(%{board: %{c3: mark, c6: mark, c9: mark}} = game)
      when is_binary(mark) do
    %{game | game_state: :won, winner: mark}
  end

  # Diagonal wins--------------------------
  def check_for_win(%{board: %{c1: mark, c5: mark, c9: mark}} = game)
      when is_binary(mark) do
    %{game | game_state: :won, winner: mark}
  end

  def check_for_win(%{board: %{c3: mark, c5: mark, c7: mark}} = game)
      when is_binary(mark) do
    %{game | game_state: :won, winner: mark}
  end

  def check_for_win(%{board: %{c3: mark, c5: mark, c7: mark}} = game)
      when is_binary(mark) do
    %{game | game_state: :won, winner: mark}
  end

  # no win, check for draw
  def check_for_win(game) do
    Map.values(game.board)
    |> Enum.member?(nil)
    |> case do
      true -> game
      false -> %{game | game_state: :draw, winner: "draw"}
    end
  end

  # player 1 just moved, it's now player 2 turn to move - game still playing
  defp update_player_move(game, _player = :x) do
    IO.puts("in update x just moved")
    IO.inspect(game)
    Map.put(game, :move, :o)
  end

  # player 2 just moved, it's now player 1 turn to move - game still playing
  defp update_player_move(game, _player = :o) do
    IO.puts("in update o just moved")
    IO.inspect(game)
    Map.put(game, :move, :x)
  end

  def computer_move(game) do
    # set best_score = -10_000_000
    # get open cells and pick a random one
    open_cells =
      for {k, nil} <- game.board,
          do: k

    # enumerate over open_cells
    # create a board map for each open_cell, where the open_cell is marked "o"
    # pass that board map to minimax with score = minimax(board, 0 , false)
    # empty out the temp board map
    # if score > best_score, set best_score = score and set move = the open_cell

    # at the end of the enumerate of open_cells, you will have a move for a single open cell, now officially call make_move() for that cell

    cell_pick = Enum.random(open_cells)

    # pick random cell
    IO.puts("Comp about to move...")
    make_move(game, cell_pick, "o", :o)
  end

  # Terminal case, game has been won or lost
  def minimax(%{game_state: state} = game, _depth, _maximizing) when state in [:win, :draw] do
    @scores[game.winner]
  end

  def minimax(board, depth, maximizing = true) do
    # check if board has a winner, if yes return @scores[winning_mark]
    case check_for_win(board) do
      nil ->
        nil
    end

    best_score = -10_000_000
    # loop over all open cells in board
    # for each cell create new board map with that cell marked "o"
    # pass new board map to minimax(board, depth + 1, false)
    # wipe board map
    # best_score = max(score, best_score)
    # -------end of loop---
  end

  def minimax(board, depth, maximizing = false) do
    # check if board has a winner, if yes return @scores[winning_mark]
    best_score = 10_000_000
    # loop over all open cells in board
    # for each cell create new board map with that cell marked "x"
    # pass new board map to minimax(board, depth + 1, true)
    # wipe board map
    # best_score = min(score, best_score)
    # -------end of loop---
  end
end
