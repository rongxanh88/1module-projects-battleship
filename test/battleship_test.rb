require './test/test_helper'
require './lib/battleship'

class BattleshipTest < Minitest::Test
  def test_instance_of_battle_ship
    game = BattleShip.new
    assert_instance_of BattleShip, game
  end
  
  def test_get_difficulty
    game = BattleShip.new
    assert_equal "beginner", game.difficulty
  end
  
end
