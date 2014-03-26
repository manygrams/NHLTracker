class Player < ActiveRecord::Base
  attr_accessible :email, :name

  validates :name, presence: true
  validates :email, presence: true
  validates :name, uniqueness: { :message => 'This person has already been created.' }
  validates :email, uniqueness: { :message => 'This email has already been used.' }

  has_many :home_games, class_name: 'Game', foreign_key: 'home_player_id'
  has_many :away_games, class_name: 'Game', foreign_key: 'away_player_id'

  def games
    (home_games.active + away_games.active).sort_by { |g| g.id }
  end

  def goals_for
    home_games.active.sum(:home_player_score) + away_games.active.sum(:away_player_score)
  end

  def goals_against
    home_games.active.sum(:away_player_score) + away_games.active.sum(:home_player_score)
  end

  def games_won
    home_games.active.home_player_won.size + away_games.active.away_player_won.size
  end

  def games_lost
    home_games.active.home_player_lost.size + away_games.active.away_player_lost.size
  end

  def win_percent
    games_won.to_f / (home_games.active.size + away_games.active.size)
  end

  def favourite_team
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
end
