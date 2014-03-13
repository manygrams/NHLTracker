class AddQuarterToGames < ActiveRecord::Migration
  def change
    add_column :games, :quarter_id, :integer
  end
end
