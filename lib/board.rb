class Board
  attr_accessor :board, :empty_spaces
  def initialize(size)
    matrix = Array.new(size) {|row| Array.new(size) {|element| element = " "}}
    @board = matrix
    @empty_spaces = []
  end

  def size
    row_length = board[0].length
  end
  
  def get_element(row_index, col_index)
    return board[row_index][col_index]
  end
  
  def set_element(row_index, col_index, element)
    board[row_index][col_index] = element
  end

  def find_empty_space(ship_length)
    empty_spaces.clear
    ship_space = []

    board.each_with_index do |row, row_index|
      row.each_with_index do |space, col_index|
        if space == " "
          #board[row_index, col_index] = "flagged"
          space = "flagged"
          ship_space << [row_index, col_index] #first empty space
          ship_length -= 1
          find_empty_neighbors(row_index, col_index, ship_length)
        end
      end
    end
    @empty_spaces
  end
  
  def find_empty_neighbors(first_index, second_index, ship_length)
    return if ship_length == 0
    neighbors = []
    target = " "

    board.each_with_index do |row, row_index|
      row.each_with_index do |space, col_index|
        if (first_index == row_index) and
          ((col_index - second_index).abs <= 1) and
          space == target
            neighbors << [row_index, col_index]
            space == "flagged"
        elsif (col_index == second_index) and
          (row_index - first_index).abs <= 1) and
          space == target
            neighbors << [row_index, col_index]
            space == "flagged"
        end
      end
    end
    
  end
  
  
  # def find_live_cells
  #   locations = []
  #   board.each_with_index do |row, row_index|
  #     row.each_with_index do |element, col_index|
  #       if element == "alive"
  #         locations << [row_index, col_index]
  #       end
  #     end
  #   end
  #   locations
  # end

  # def find_neighbors(target="", row_index, col_index)
  #   neighbors = []
  #   board.each_with_index do |row, y_index|
  #     row.each_with_index do |element, x_index|
  #       if ((y_index - row_index).abs <= 1) and ((x_index - col_index).abs <= 1)
  #         if (y_index == row_index) and (x_index == col_index)
  #           #do nothing
  #         elsif element == target
  #           neighbors << [y_index, x_index]
  #         end
  #       end
  #     end
  #   end
  #   neighbors
  # end

  private
  
  
end