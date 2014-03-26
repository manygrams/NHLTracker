class AddIndexToGames < ActiveRecord::Migration
  def change
    add_index :games, :home_player_id
    add_index :games, :away_player_id
  end
end
