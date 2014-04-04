class CalculateStatsForExistingPlayers < ActiveRecord::Migration
  def up
    Player.all.each do |player|
      player.update_statistics
    end
  end

  def down
  end
end
