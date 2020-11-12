defmodule Tictactoe.GameSupervisor do
  use DynamicSupervisor

  @game_id_length 3

  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_game_server(game_id) do
    DynamicSupervisor.start_child(
      __MODULE__,
      {Tictactoe.GameServer, [game_id]}
    )
  end

  def create_temp_fake_game_id do
    :crypto.strong_rand_bytes(@game_id_length)
    |> Base.encode64()
    |> binary_part(0, @game_id_length)
  end
end
