require './test/test_helper'
require './lib/validate'
require './lib/board'

class ValidateTest < Minitest::Test

  def test_instance_of_validator
    board = Board.new(4)
    validator = Validate.new(board)
    assert_instance_of Validate, validator
  end
  
  def test_validate_coordinate
    board = Board.new(4)
    validator = Validate.new(board)
    assert validator.validate("A1")
    assert validator.validate("B2")
    assert validator.validate("C3")
    assert validator.validate("D4")
    refute validator.validate("A5")
    refute validator.validate("B0")
    refute validator.validate("E9")
    refute validator.validate("F-10")
  end

  def test_validate_coordinates_are_in_line
    board = Board.new(4)
    validator = Validate.new(board)
    assert validator.validate_in_line("A1", "A3")
    assert validator.validate_in_line("A1", "B1")
    assert validator.validate_in_line("D2", "D3")
    refute validator.validate_in_line("A1", "B3")
    refute validator.validate_in_line("C1", "D3")
    refute validator.validate_in_line("E1", "D3")
  end

  def test_validate_all_empty
    board = Board.new(4)
    validator = Validate.new(board)
    assert validator.validate_all_empty("A1", "A3")
  end

  def test_same_letter
    board = Board.new(4)
    validator = Validate.new(board)
    assert validator.same_letter?("A1", "A3")
    refute validator.same_letter?("C1", "D3")
  end

  def test_same_number
    board = Board.new(4)
    validator = Validate.new(board)
    assert validator.same_number?("A1", "B1")
    refute validator.same_number?("D1", "B3")
  end

  def test_column_empty
    board = Board.new(4)
    validator = Validate.new(board)
    assert validator.column_empty?(["A", "1"], ["C", "1"])

    board2 = Board.new(4)
    board2.set_element(2, 2, "2")
    refute validator.column_empty?(["A", "3"], ["C", "3"])
  end

  def test_row_empty
    board = Board.new(4)
    validator = Validate.new(board)
    assert validator.row_empty?(["A", "1"], ["A", "3"])

    board2 = Board.new(4)
    board2.set_element(2, 2, "2")
    refute validator.row_empty?(["C", "2"], ["C", "4"])
  end
end