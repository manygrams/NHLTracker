module GamesHelper
  def all_players
    Player.all.sort_by { |p| p.name.downcase }.map { |p| [ p.name, p.id ] }
  end

  def all_teams
    GamesController::NHL_TEAMS
  end
end
