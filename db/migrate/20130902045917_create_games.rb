class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :home_team
      t.string :away_team
      t.integer :home_player_id
      t.integer :away_player_id
      t.integer :home_player_score
      t.integer :away_player_score

      t.timestamps
    end
  end
end
