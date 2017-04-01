require './test/test_helper'
require './lib/battleship'

class BattleshipTest < Minitest::Test
  def test_instance_of_battle_ship
    game = BattleShip.new
    assert_instance_of BattleShip, game
  end
  
end
