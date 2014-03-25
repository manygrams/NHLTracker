class Player < ActiveRecord::Base
  attr_accessible :email, :name

  validates :name, presence: true
  validates :email, presence: true
  validates :name, uniqueness: { :message => 'This person has already been created.' }
  validates :email, uniqueness: { :message => 'This email has already been used.' }

  has_many :home_games, class_name: 'Game', foreign_key: 'home_player_id'
  has_many :away_games, class_name: 'Game', foreign_key: 'away_player_id'

  def won_game(game)
  end

  def games
    (home_games.active + away_games.active).sort_by { |g| g.id }
  end

  def goals
    home_goals + away_goals
  end

  def opposition_goals
    opposition_home_goals + opposition_away_goals
  end

  def home_goals
    home_games.active.inject(0) { |goals, game| goals + game.home_player_score }
  end

  def opposition_home_goals
    home_games.active.inject(0) { |goals, game| goals + game.away_player_score }
  end

  def away_goals
    away_games.active.inject(0) { |goals, game| goals + game.away_player_score }
  end

  def opposition_away_goals
    away_games.active.inject(0) { |goals, game| goals + game.home_player_score }
  end

  def games_won
    home_games_won + away_games_won
  end

  def win_percent
    games.empty? ? 0 : (games_won.length.to_f / games.length.to_f)
  end

  def games_lost
    home_games_lost + away_games_lost
  end

  def home_games_won
    self.home_games.active.select { |g| g.home_player_score > g.away_player_score }
  end

  def away_games_won
    self.away_games.active.select { |g| g.away_player_score > g.home_player_score }
  end

  def home_games_lost
    self.home_games.active.select { |g| g.away_player_score > g.home_player_score }
  end

  def away_games_lost
    self.away_games.active.select { |g| g.home_player_score > g.away_player_score }
  end

  def best_team
    if games_won.empty?
      nil
    else
      GamesController::NHL_TEAMS.keys.sort_by { |team| team_win_percent(team) }.last
    end
  end

  private

  def team_win_percent(team)
    team_home_wins = Game.active.where(home_player_id: self.id, home_team: team).select { |g| g.home_player_score > g.away_player_score }
    team_away_wins = Game.active.where(away_player_id: self.id, away_team: team).select { |g| g.away_player_score > g.home_player_score }

    team_home_losses = Game.active.where(home_player_id: self.id, home_team: team).select { |g| g.away_player_score > g.home_player_score }
    team_away_losses = Game.active.where(away_player_id: self.id, away_team: team).select { |g| g.home_player_score > g.away_player_score }
    if team_home_wins.empty? && team_away_wins.empty?
      0
    else
      (100*((team_home_wins + team_away_wins).length.to_f / (team_home_wins + team_away_wins + team_home_losses + team_away_losses).length.to_f)).to_i
    end
  end
end
