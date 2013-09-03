require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, game: { away_player_id: @game.away_player_id, away_team: @game.away_team, away_team_score: @game.away_team_score, home_player_id: @game.home_player_id, home_player_score: @game.home_player_score, home_team: @game.home_team }
    end

    assert_redirected_to game_path(assigns(:game))
  end

  test "should show game" do
    get :show, id: @game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game
    assert_response :success
  end

  test "should update game" do
    put :update, id: @game, game: { away_player_id: @game.away_player_id, away_team: @game.away_team, away_team_score: @game.away_team_score, home_player_id: @game.home_player_id, home_player_score: @game.home_player_score, home_team: @game.home_team }
    assert_redirected_to game_path(assigns(:game))
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_redirected_to games_path
  end
end
