class SetDefaultOnArchived < ActiveRecord::Migration
  def up
    change_column :games, :archived, :boolean, :default => false
  end

  def down
    change_column :games, :archived, :boolean, :default => nil
  end
end
