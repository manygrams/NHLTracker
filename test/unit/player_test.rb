require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  def setup
    @nick = players(:nick)
    @not_nick = players(:not_nick)

    @first_game = games(:one)
    @second_game = games(:two)
  end
end
