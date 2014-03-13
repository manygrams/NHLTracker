class RemoveArchivedFromGames < ActiveRecord::Migration
  def up
    remove_column :games, :archived
  end

  def down
    add_column :games, :archived, :boolean
  end
end
