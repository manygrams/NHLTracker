class Player < ActiveRecord::Base
  attr_accessible :email, :name, :goals_for, :goals_against, :games_won, :games_lost, :win_percent, :favourite_team

  validates :name, presence: true
  validates :email, presence: true
  validates :name, uniqueness: { :message => 'This person has already been created.' }
  validates :email, uniqueness: { :message => 'This email has already been used.' }

  has_many :home_games, class_name: 'Game', foreign_key: 'home_player_id'
  has_many :away_games, class_name: 'Game', foreign_key: 'away_player_id'

  def self.ranked
    Player.all.sort_by { |player| -player.win_percent }
  end

  def games
    (home_games.active + away_games.active).sort_by { |g| g.id }
  end

  def calculate_goals_for
    home_games.active.sum(:home_player_score) + away_games.active.sum(:away_player_score)
  end

  def calculate_goals_against
    home_games.active.sum(:away_player_score) + away_games.active.sum(:home_player_score)
  end

  def calculate_games_won
    home_games.active.home_player_won.size + away_games.active.away_player_won.size
  end

  def calculate_games_lost
    home_games.active.home_player_lost.size + away_games.active.away_player_lost.size
  end

  def calculate_win_percent
    win_percent = games_won.to_f / (home_games.active.size + away_games.active.size)
    win_percent.nil? | win_percent.nan? ? 0 : win_percent
  end

  def calculate_favourite_team
    if games_won == 0
      nil
    else
      result = ActiveRecord::Base.connection.execute <<-SQL
        SELECT
          CASE
            WHEN (p.id = g.home_player_id) THEN g.home_team
            WHEN (p.id = g.away_player_id) THEN g.away_team
          END AS team_name
        FROM players p
        INNER JOIN games g
        ON p.id = g.home_player_id OR p.id = g.away_player_id
        WHERE p.id = #{id} AND NOT g.archived
        GROUP BY team_name
        ORDER BY COUNT(1) DESC
        LIMIT 1
      SQL
      result.first['team_name']
    end
  end

  def update_statistics
    update_attribute(:goals_for, calculate_goals_for)
    update_attribute(:goals_against, calculate_goals_against)
    update_attribute(:games_won, calculate_games_won)
    update_attribute(:games_lost, calculate_games_lost)
    update_attribute(:win_percent, calculate_win_percent)
    update_attribute(:favourite_team, calculate_favourite_team)
  end
end
