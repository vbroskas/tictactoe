defmodule Tictactoe.Game do
  @game %{
    game_state: :playing,
    move: :x,
    winner: nil,
    winning_cells: [],
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

  # minimax written where comp "O" is the maximizing player
  @scores %{
    "X" => -10,
    "O" => 10,
    "draw" => 0
  }

  def start_game(true) do
    @game
  end

  def start_game(false) do
    %{@game | move: :o}
    |> comp_move_smart()
  end

  def make_move(%{move: player_to_move, game_state: :playing} = game, cell, mark, player)
      when player == player_to_move do
    game
    |> mark_cell(cell, mark)
    |> update_player_move(player)
    |> check_if_game_over
  end

  @doc """
  wrong player trying to move
  """
  def make_move(%{move: player_to_move} = game, _cell, _mark, player)
      when player != player_to_move do
    IO.puts("WRONG PLAYER TRYING TO MOVE, it's #{player_to_move}'s turn!")
    game
  end

  @doc """
  game is over, no not allow additional moves
  """
  def make_move(%{game_state: state} = game, _cell, _mark, _player)
      when state in [:won, :draw] do
    game
  end

  # Mark a cell on the board
  def mark_cell(game, cell, mark) do
    %{game | board: Map.put(game.board, cell, mark)}
    |> check_for_win()
  end

  def computer_random_move(game) do
    cell_pick =
      get_open_cells(game)
      |> Enum.random()

    make_move(game, cell_pick, "O", :o)
  end

  def comp_move_smart(game) do
    open_cells = get_open_cells(game)

    {_best_score, cell} =
      Enum.reduce(open_cells, {-1000, nil}, fn cell, {best_score, move} ->
        new_game_state = mark_cell(game, cell, "O")
        score = minimax(new_game_state, 0, -1000, 1000, false)

        if score > best_score do
          {score, cell}
        else
          {best_score, move}
        end
      end)

    make_move(game, cell, "O", :o)
  end

  # still playing computers turn
  defp check_if_game_over(%{game_state: :playing, move: :o} = game) do
    # TURN OFF comp_move_smart  when running some tests and just return a game map here!
    comp_move_smart(game)
    # game
  end

  # still playing, human turn
  defp check_if_game_over(%{game_state: :playing, move: :x} = game) do
    game
  end

  # GAME OVER, return game
  defp check_if_game_over(%{game_state: state, winner: _winner} = game)
       when state in [:won, :draw] do
    game
  end

  # Horizontal wins--------------------------
  defp check_for_win(%{board: %{c1: mark, c2: mark, c3: mark}} = game) when is_binary(mark) do
    %{game | game_state: :won, winner: mark, winning_cells: [:c1, :c2, :c3]}
  end

  defp check_for_win(%{board: %{c4: mark, c5: mark, c6: mark}} = game)
       when is_binary(mark) do
    %{game | game_state: :won, winner: mark, winning_cells: [:c4, :c5, :c6]}
  end

  defp check_for_win(%{board: %{c7: mark, c8: mark, c9: mark}} = game)
       when is_binary(mark) do
    %{game | game_state: :won, winner: mark, winning_cells: [:c7, :c8, :c9]}
  end

  # Vertical wins--------------------------
  defp check_for_win(%{board: %{c1: mark, c4: mark, c7: mark}} = game)
       when is_binary(mark) do
    %{game | game_state: :won, winner: mark, winning_cells: [:c1, :c4, :c7]}
  end

  defp check_for_win(%{board: %{c2: mark, c5: mark, c8: mark}} = game)
       when is_binary(mark) do
    %{game | game_state: :won, winner: mark, winning_cells: [:c2, :c5, :c8]}
  end

  defp check_for_win(%{board: %{c3: mark, c6: mark, c9: mark}} = game)
       when is_binary(mark) do
    %{game | game_state: :won, winner: mark, winning_cells: [:c3, :c6, :c9]}
  end

  # Diagonal wins--------------------------
  defp check_for_win(%{board: %{c1: mark, c5: mark, c9: mark}} = game)
       when is_binary(mark) do
    %{game | game_state: :won, winner: mark, winning_cells: [:c1, :c5, :c9]}
  end

  defp check_for_win(%{board: %{c3: mark, c5: mark, c7: mark}} = game)
       when is_binary(mark) do
    %{game | game_state: :won, winner: mark, winning_cells: [:c3, :c5, :c7]}
  end

  # no win, check for draw
  defp check_for_win(game) do
    Map.values(game.board)
    |> Enum.member?(nil)
    |> case do
      true -> game
      false -> %{game | game_state: :draw, winner: "draw"}
    end
  end

  # player 1 just moved, now player 2 move
  defp update_player_move(game, _player = :x) do
    Map.put(game, :move, :o)
  end

  # player 2 just moved, now player 1 move
  defp update_player_move(game, _player = :o) do
    Map.put(game, :move, :x)
  end

  @doc """
  Base cases, game has been won,lost or draw. return score with adjustment for depth
  """
  defp minimax(%{game_state: state, winner: "X"} = game, depth, _alpha, _beta, _maximizing)
       when state in [:won, :draw] do
    @scores[game.winner] + depth
  end

  defp minimax(%{game_state: state, winner: "O"} = game, depth, _alpha, _beta, _maximizing)
       when state in [:won, :draw] do
    @scores[game.winner] - depth
  end

  defp minimax(%{game_state: state, winner: "draw"} = game, _depth, _alpha, _beta, _maximizing)
       when state in [:won, :draw] do
    @scores[game.winner]
  end

  @doc """
  "O" (computer) is the maximizing player
  alpha starts at -1000, beta at 1000.
  the accumulator in this funciton only needs to account for a "best score" (initialized at -1000) and the alpha accumulator {-1000, alpha}
  alpha represents the best already discovered score along the path to the root for the maximizer
  When it is maximixing turn, it wants a score that's greater than the current alpha, but <= than current beta
  """
  defp minimax(game, depth, alpha, beta, _maximizing = true) do
    {score, _} =
      get_open_cells(game)
      |> Enum.reduce_while({-1000, alpha}, fn cell, {acc, alpha_acc} ->
        new_game_state = mark_cell(game, cell, "O")

        score = minimax(new_game_state, depth + 1, alpha_acc, beta, false)
        new_acc = max(score, acc)
        new_alpha = max(new_acc, alpha_acc)

        if beta <= new_alpha do
          {:halt, {new_acc, alpha_acc}}
        else
          {:cont, {new_acc, new_alpha}}
        end
      end)

    score
  end

  @doc """
  "X" (human) is the minimizing player
  the accumulator in this funciton only needs to account for a "best score" (initialized at 1000) and the beta accumulator {1000, beta}
  beta represents the best already discovered score along the path to the root for the maximizer
  When it is minimizing turn, it wants a score that's less than the current beta, but greater than current alpha

  """
  defp minimax(game, depth, alpha, beta, _maximizing = false) do
    {score, _} =
      get_open_cells(game)
      |> Enum.reduce_while({1000, beta}, fn cell, {acc, beta_acc} ->
        new_game_state = mark_cell(game, cell, "X")

        score = minimax(new_game_state, depth + 1, alpha, beta_acc, true)
        new_acc = min(score, acc)
        new_beta = min(new_acc, beta_acc)

        if new_beta <= alpha do
          {:halt, {new_acc, beta_acc}}
        else
          {:cont, {new_acc, new_beta}}
        end
      end)

    score
  end

  @doc """
  get all open cells on the game board
  """
  defp get_open_cells(game) do
    for {k, nil} <- game.board,
        do: k
  end
end
