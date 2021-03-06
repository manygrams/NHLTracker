# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140403212024) do

  create_table "games", :force => true do |t|
    t.string   "home_team"
    t.string   "away_team"
    t.integer  "home_player_id"
    t.integer  "away_player_id"
    t.integer  "home_player_score"
    t.integer  "away_player_score"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "archived",          :default => false
  end

  add_index "games", ["away_player_id"], :name => "index_games_on_away_player_id"
  add_index "games", ["home_player_id"], :name => "index_games_on_home_player_id"

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "goals_for",      :default => 0
    t.integer  "goals_against",  :default => 0
    t.integer  "games_won",      :default => 0
    t.integer  "games_lost",     :default => 0
    t.float    "win_percent",    :default => 0.0
    t.string   "favourite_team"
  end

end
