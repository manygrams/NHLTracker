class AddStatisticsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :goals_for, :integer, default: 0
    add_column :players, :goals_against, :integer, default: 0
    add_column :players, :games_won, :integer, default: 0
    add_column :players, :games_lost, :integer, default: 0
    add_column :players, :win_percent, :float, default: 0
    add_column :players, :favourite_team, :string
  end
end
