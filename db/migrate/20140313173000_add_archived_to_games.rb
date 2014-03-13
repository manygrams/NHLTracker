class AddArchivedToGames < ActiveRecord::Migration
  def change
    add_column :games, :archived, :boolean

    Game.all.each do |game|
      game.created_at < Date.new(2014, 1, 1) ? game.archived = true : game.archived = false
      game.save!
    end
  end
end
