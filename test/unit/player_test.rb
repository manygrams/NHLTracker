require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  def setup
    @nick = players(:nick)
    @not_nick = players(:not_nick)
  end

  test "win_percent returns what is expected" do
    @first_game = games(:one)
    @second_game = games(:two)

    assert_equal @nick.win_percent, 0.5
    assert_equal @not_nick.win_percent, 0.5

    @second_game.delete

    assert_equal @nick.win_percent, 1
    assert_equal @not_nick.win_percent, 0
  end
end
