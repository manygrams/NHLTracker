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

  def goals
    result = ActiveRecord::Base.connection.execute <<-SQL
      SELECT
        SUM(
          (p.id = g.home_player_id)::INT * g.home_player_score + 
          (p.id = g.away_player_id)::INT * g.away_player_score
        ) AS goals
      FROM players p
      INNER JOIN games g
      ON p.id = g.home_player_id OR p.id = g.away_player_id
      WHERE p.id = #{id} AND NOT g.archived
    SQL
    result.first["goals"]
  end

  def opposition_goals
    result = ActiveRecord::Base.connection.execute <<-SQL
      SELECT
        SUM(
          (p.id = g.home_player_id)::INT * g.away_player_score + 
          (p.id = g.away_player_id)::INT * g.home_player_score
        ) AS goals_against
      FROM players p
      INNER JOIN games g
      ON p.id = g.home_player_id OR p.id = g.away_player_id
      WHERE p.id = #{id} AND NOT g.archived
    SQL
    result.first["goals_against"]
  end

  def games_won
    result = ActiveRecord::Base.connection.execute <<-SQL
      SELECT
        SUM((
          p.id = g.home_player_id AND g.home_player_score > g.away_player_score OR
          p.id = g.away_player_id AND g.away_player_score > g.home_player_score
        )::INT) AS games_won
      FROM players p
      INNER JOIN games g
      ON p.id = g.home_player_id OR p.id = g.away_player_id
      WHERE p.id = #{id} AND NOT g.archived
    SQL
    result.first['games_won'].to_i
  end

  def win_percent
    result = ActiveRecord::Base.connection.execute <<-SQL
      SELECT
        SUM((
          p.id = g.home_player_id AND g.home_player_score > g.away_player_score OR
          p.id = g.away_player_id AND g.away_player_score > g.home_player_score
        )::INT)::FLOAT / COUNT(1) AS win_pct
      FROM players p
      INNER JOIN games g
      ON p.id = g.home_player_id OR p.id = g.away_player_id
      WHERE p.id = #{id} AND NOT g.archived
    SQL
    result.first['win_pct'].to_f
  end

  def games_lost
    result = ActiveRecord::Base.connection.execute <<-SQL
      SELECT
        SUM((
          p.id = g.home_player_id AND g.home_player_score < g.away_player_score OR
          p.id = g.away_player_id AND g.away_player_score < g.home_player_score
        )::INT) AS games_lost
      FROM players p
      INNER JOIN games g
      ON p.id = g.home_player_id OR p.id = g.away_player_id
      WHERE p.id = #{id} AND NOT g.archived
    SQL
    result.first['games_lost'].to_i
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
