ActiveRecord::Schema.define(:version => 20130902045934) do

  create_table "games", :force => true do |t|
    t.string   "home_team"
    t.string   "away_team"
    t.integer  "home_player_id"
    t.integer  "away_player_id"
    t.integer  "home_player_score"
    t.integer  "away_player_score"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
