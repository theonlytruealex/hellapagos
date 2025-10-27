defmodule MyGame.Room do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    start_state = %{
      players: [],
      water_deck: [],
      scavenge_deck: [],
      food: 0,
      water: 0,
      wood: 0,
      boats: 0
    }

    {:ok, starter_state}
  end

  def handle_cast({:join, player_id}, state) do
    updated_state = %{
      state
      | players: [player_id | state.players]
    }

    {:noreply, updated_state}
  end

  def handle_call(:get_players, _from, state) do
    {:reply, state, state}
  end

  def handle_info({:remove_player, player_id}, state) do
    updated_state = List.delete(state, player_id)
    {:noreply, updated_state}
  end
end
