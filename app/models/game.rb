class Game < ActiveRecord::Base
  attr_accessible :away_player_id, :away_team, :away_player_score, :home_player_id, :home_player_score, :home_team
end
