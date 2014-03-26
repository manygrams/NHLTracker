module PlayersHelper
  def ranked_list_class(player)
    player.games_won == 0 ? 'no-wins' : 'has-won'
  end

  def players_with_no_wins?
    @ranked_players.any? { |player| player.games_won == 0 }
  end
end
