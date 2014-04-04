require 'test_helper'

class NewGameFlowTest < ActionDispatch::IntegrationTest
  fixtures :players, :games

  test "adding new game updates index and each player's show page" do
    @nick = players(:nick)
    @not_nick = players(:not_nick)

    post_via_redirect '/games', { game: { home_player_id: @nick.id, away_player_id: @not_nick.id, home_player_score: 2, away_player_score: 1, home_team: "Montreal Canadiens", away_team: "Boston Bruins" }}

    get '/'

    assert_select "tr#player-#{@nick.id}" do
      assert_select "td.player-favourite-team", "Montreal Canadiens"
      assert_select "td.player-games-won", "2"
      assert_select "td.player-games-lost", "1"
      assert_select "td.player-goals-for", "12"
      assert_select "td.player-win-percent", "0.667"
    end

    assert_select "tr#player-#{@not_nick.id}" do
      assert_select "td.player-favourite-team", "Boston Bruins"
      assert_select "td.player-games-won", "1"
      assert_select "td.player-games-lost", "2"
      assert_select "td.player-goals-for", "11"
      assert_select "td.player-win-percent", "0.333"
    end

    get "/players/#{@nick.id}"
    assert_select "h4#stat-win-percent", "0.667"
    assert_select "h4#stat-games-won", "2"
    assert_select "h4#stat-games-lost", "1"
    assert_select "h4#stat-goals-for", "12"
    assert_select "h4#stat-goals-against", "11"

    get "/players/#{@not_nick.id}"
    assert_select "h4#stat-win-percent", "0.333"
    assert_select "h4#stat-games-won", "1"
    assert_select "h4#stat-games-lost", "2"
    assert_select "h4#stat-goals-for", "11"
    assert_select "h4#stat-goals-against", "12"
  end
end
