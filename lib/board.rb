class Board
  attr_accessor :board
  def initialize(size)
    row = Array.new(size, ' ')
    @board = Array.new(size, row)
  end
  
end