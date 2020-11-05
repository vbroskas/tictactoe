defmodule Tictactoe.Game do
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
    #! !!!!! I forgot that from the perspective of the computer playing, THE COMP IS THE MAXIMIZING PLAYER!!!
    # x should be -10!!!
    "x" => -10,
    "o" => 10,
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

  # still playing computers turn
  def check_if_game_over(%{game_state: :playing, move: :o} = game) do
    # computer_move(game)
    comp_move_smart(game)
  end

  # still playing, human turn
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
    Map.put(game, :move, :o)
  end

  # player 2 just moved, it's now player 1 turn to move - game still playing
  defp update_player_move(game, _player = :o) do
    IO.puts("in update o just moved")
    IO.inspect(game)
    Map.put(game, :move, :x)
  end

  def computer_move(game) do
    cell_pick =
      get_open_cells(game)
      |> Enum.random()

    make_move(game, cell_pick, "o", :o)
  end

  def comp_move_smart(game) do
    open_cells = get_open_cells(game)

    {_best_score, cell} =
      Enum.reduce(open_cells, {-1000, nil}, fn cell, {best_score, move} ->
        new_game_state = mark_cell(game, cell, "o")
        score = minimax(new_game_state, 0, false)

        IO.puts("<<<<<<<<<< #{cell} >>> #{best_score} >>>>> #{move} >>>>")

        if score > best_score do
          IO.puts("=====NEW HIGH=======")
          IO.inspect("Score: #{score}, cell: #{cell}")
          {score, cell}
        else
          IO.puts("=====NO CHANGE=======")
          IO.inspect("current-score: #{best_score}, current-cell: #{move}")
          {best_score, move}
        end
      end)

    make_move(game, cell, "o", :o)
  end

  # def minimax(game, depth = 2, _) do
  #   IO.puts("OUT---")
  #   IO.inspect(game)
  #   IO.puts("------")
  # end

  # Terminal case, game has been won,lost or draw.
  def minimax(%{game_state: state} = game, depth, _maximizing)
      when state in [:won, :draw] do
    # cond do
    #   game.winner == "x" -> @scores[game.winner] + depth
    #   game.winner == "o" -> @scores[game.winner] - depth
    #   game.winner == "draw" -> @scores[game.winner]
    # end
    @scores[game.winner]
  end

  def minimax(game, depth, _maximizing = true) do
    # get all open cells
    open_cells = get_open_cells(game)

    best_score =
      Enum.reduce(open_cells, -1000, fn cell, acc ->
        # comp play
        new_game_state = mark_cell(game, cell, "o")
        score = minimax(new_game_state, depth + 1, false)
        max(score, acc)
      end)

    best_score
  end

  def minimax(game, depth, _maximizing = false) do
    # get all open cells
    open_cells = get_open_cells(game)

    best_score =
      Enum.reduce(open_cells, 1000, fn cell, acc ->
        # human play
        new_game_state = mark_cell(game, cell, "x")
        score = minimax(new_game_state, depth + 1, true)
        min(score, acc)
      end)

    best_score
  end

  defp get_open_cells(game) do
    for {k, nil} <- game.board,
        do: k
  end
end
