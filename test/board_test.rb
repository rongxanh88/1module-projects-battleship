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
    skip
    board = Board.new(5)
    board.set_element(0,0, "hit")
    board.set_element(0,2, "hit")
    expected = [[0,0], [0,2]]
    assert_equal expected, board.find_neighbors("hit", 0, 1)
  end
  
  def test_get_random_board_location
    board = Board.new(5)
    row_index = board.get_random_board_digit
    col_index = board.get_random_board_digit

    assert row_index > 0
    assert row_index < board.size
    assert col_index > 0
    assert col_index < board.size
  end
  
  # binding.pry
end
