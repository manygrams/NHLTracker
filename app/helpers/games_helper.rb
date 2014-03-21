module GamesHelper
  def players_for_autocomplete
    players = Player.all.sort_by { |player| player.name.downcase }
    players = players.map { |player| "{ label: '#{player.name}', id: '#{player.id}' }" }
    "[#{players.join(",")}]".html_safe
  end

  def teams_for_autocomplete
    "['#{GamesController::NHL_TEAMS.keys.join("','")}']".html_safe
  end
end
