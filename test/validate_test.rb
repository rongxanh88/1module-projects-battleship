require './test/test_helper'
require './lib/validate'
require './lib/board'

class ValidateTest < Minitest::Test

  def test_instance_of_validator
    board = Board.new(4)
    validator = Validate.new(board)
    assert_instance_of Validate, validator
  end
  
  def test_validate_coordinates
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
end