Player.create(name: 'Nick Evans',   email: 'nicolas.evans@jadedpixel.com')
Player.create(name: 'Dan King',     email: 'daniel.king@jadedpixel.com')
Player.create(name: 'Derek Pawsey', email: 'derek.pawsey@jadedpixel.com')
Player.create(name: 'Casey Whalen', email: 'casey.whalen@jadedpixel.com')
Player.create(name: 'Ben Courtice', email: 'ben.courtice@jadedpixel.com')
Player.create(name: 'Dan Eveleigh', email: 'dan.eveleigh@jadedpixel.com')

20.times do
  players = Player.all.sample(2)
  teams   = GamesController::NHL_TEAMS.keys.sample(2)
  scores  = (0..6).to_a.sample(2)

  home_player       = players.first
  home_team         = teams.first
  home_player_score = scores.first

  away_player       = players.last
  away_team         = teams.last
  away_player_score = scores.last

  Game.create(home_team: home_team,
              away_team: away_team,
              home_player_id: home_player.id,
              away_player_id: away_player.id,
              home_player_score: home_player_score,
              away_player_score: away_player_score)
end