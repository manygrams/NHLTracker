require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  setup do
    @player = players(:nick)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create player" do
    assert_difference ->{ Player.count } do
      post :create, player: { email: "test@example.com", name: "Test McTest" }
    end
  end

  test "should show player" do
    get :show, id: @player
    assert_response :success

    assert_select "h4#stat-win-percent", "0.500"
    assert_select "h4#stat-games-won", "1"
    assert_select "h4#stat-games-lost", "1"
    assert_select "h4#stat-goals-for", "10"
    assert_select "h4#stat-goals-against", "10"
  end

  test "ranked player list should display stats correctly" do
    get :index

    @ranked_players = Player.ranked

    assert_select "tr.ranked-player-row.has-won" do |elements|
      elements.each do |element|
        current_player = @ranked_players.shift

        assert_select element, "td.player-favourite-team", current_player.favourite_team.to_s
        assert_select element, "td.player-games-won",      current_player.games_won.to_s
        assert_select element, "td.player-games-lost",     current_player.games_lost.to_s
        assert_select element, "td.player-goals-for",      current_player.goals_for.to_s
        assert_select element, "td.player-win-percent",    sprintf("%.3f", current_player.win_percent)
      end
    end

    assert_select "tr.ranked-player-row.no-wins" do |elements|
      elements.each do |element|
        current_player = @ranked_players.shift

        assert_select element, "td.player-favourite-team", "Player has not won any games"
        assert_select element, "td.player-games-won",      "0"
        assert_select element, "td.player-games-lost",     current_player.games_lost.to_s
        assert_select element, "td.player-goals-for",      current_player.goals_for.to_s
        assert_select element, "td.player-win-percent",    "0.000"
      end
    end
  end
end
