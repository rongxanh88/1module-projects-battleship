require './test/test_helper'
require './lib/board'

class BoardTest < Minitest::Test

  def test_instance_of_board
    player_board = Board.new(5)
    assert_instance_of Board, player_board
  end

  def test_get_row_length
    board = Board.new(10)
    assert_equal 10, board.size
  end
  
  def test_set_then_get_element
    board = Board.new(5)
    board.set_element(0,0, "Hello")
    assert_equal "Hello", board.get_element(0,0)
  end

  def test_get_neighbors_with_hit
    board = Board.new(5)
    board.set_element(0,0, "hit")
    board.set_element(0,2, "hit")
    expected = [[0,0], [0,2]]
    assert_equal expected, board.find_neighbors("hit", 0, 1)
  end
  
  
  # binding.pry
end
