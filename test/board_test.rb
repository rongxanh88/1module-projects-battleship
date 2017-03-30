require './test/test_helper'
require './lib/board'

class BoardTest < Minitest::Test

  def test_instance_of_board
    player_board = Board.new(5)
    assert_instance_of Board, player_board
  end
  #binding.pry
end
