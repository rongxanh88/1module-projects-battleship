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
  
  def test_grab_random_empty_space
    board = Board.new(4)
    row, col = board.grab_random_empty_space 
    assert row >= 0
    assert row < board.size
    assert col >= 0
    assert col < board.size
    assert_equal " ", board.get_element(row, col)
  end

  def test_get_random_direction
    board = Board.new(5)
    rand_dir = board.direction.to_a.sample(1).to_h
  end
  
  def test_zip_start_square_and_direction
    board = Board.new(5)
    dir_value = board.direction["N"]
    start = [1,1]
    result = start.zip(dir_value).map{|arr| arr.inject(:+)}
    assert_equal [0,1], result
  end

  def test_find_consecutive_empty_neighbors
    board = Board.new(5)
    row, col, ship_length = 0, 0, 2
    dir = board.direction["E"]
    neighbors = []
    neighbors << board.find_empty_neighbors(row, col, ship_length, dir)
    neighbors.flatten!.compact!
    neighbors = neighbors.each_slice(2).to_a
    expected = [[0, 1], [0, 2]]
    assert_equal expected, neighbors
  end
  
  def test_find_space_for_ship
    board = Board.new(5)
    empty_spaces = board.find_ship_space(3)
    assert_equal 3, empty_spaces.size
  end

  def test_find_direction
    board = Board.new(4)
    assert_equal [0,1], board.find_direction("A1", "A3")
    assert_equal [0,-1], board.find_direction("A3", "A1")
    assert_equal [-1,0], board.find_direction("C1", "A1")
    assert_equal [1,0], board.find_direction("A1", "C1")
  end
  
end
