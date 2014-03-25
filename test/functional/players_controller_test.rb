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
  end
  test "ranked player list should display stats correctly" do
    get :index

    assert_select "tr.ranked-player-row" do |elements|
      elements.each do |element|
        assert_select "td.win-percent", "0.500"
      end
    end
  end
end
