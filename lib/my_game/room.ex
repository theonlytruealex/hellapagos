defmodule MyGame.Room do
  use GenServer

  # Client functions

  def start_link({name, players}) do
    GenServer.start_link(__MODULE__, players, name: __MODULE__)
  end

  def update_score(pid, kind, amount) do
    GenServer.cast(pid, {:update_stat, kind, amount})
  end

  # Server functions

  @impl true
  def init(players) do
    starter_state = %{
      players: players,
      alive_players: players,
      water_deck: [],
      scavenge_deck: [],
      food: 0,
      water: 0,
      wood: 0,
      boats: 0
    }

    {:ok, starter_state}
  end

  @impl true
  def handle_cast({:update_stat, stat, amount}, state) do
    updated_state =
      Map.update!(state, stat, fn existing_value -> existing_value + amount end)

    {:noreply, updated_state}
  end

  def handle_cast({:remove_player, player_id}, state) do
    updated_state =
      Map.update!(state, :players, fn player_list ->
        List.delete(player_list, player_id)
      end)

    {:noreply, updated_state}
  end

  def handle_cast({:kill_player, player_id}, state) do
    updated_state =
      Map.update!(state, :alive_players, fn player_list ->
        List.delete(player_list, player_id)
      end)

    {:noreply, updated_state}
  end

  def handle_cast({:revive_player, player_id}, state) do
    updated_state =
      Map.update!(state, :alive_players, fn player_list ->
        [player_id | player_list]
        |> Enum.uniq()
      end)

    {:noreply, updated_state}
  end

  @impl true
  def handle_call(:get_players, _from, state) do
    {:reply, state.players, state}
  end

  def handle_call(:get_player_count, _from, state) do
    {:reply, length(state.players), state}
  end

  @impl true
  def handle_call(:draw_water, _from, state) do
    case state.water_deck do
      [water_card | remaining_deck] ->
        updated_state = %{state | water_deck: remaining_deck}
        {:reply, {:ok, water_card}, updated_state}

      [] ->
        {:reply, :deck_empty, state}
    end
  end

  @impl true
  def handle_call(:scavenge, _from, state) do
    case state.scavenge_deck do
      [scavenge_card | remaining_deck] ->
        updated_state = %{state | scavenge_deck: remaining_deck}
        {:reply, {:ok, scavenge_card}, updated_state}

      [] ->
        {:reply, :deck_empty, state}
    end
  end
end
