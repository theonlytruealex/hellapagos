defmodule MyGame.Room do
  use GenServer

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:join, player_id}, state) do
    updated_state = [player_id | state]
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
