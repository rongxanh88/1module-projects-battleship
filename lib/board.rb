class Board
  attr_accessor :board
  def initialize(size)
    matrix = Array.new(size) {|row| Array.new(size) {|element| element = " "}}
    @board = matrix
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

  def find_neighbor_indexes(target="", row_index, col_index)
    neighbors = []
    board.each_with_index do |row, y_index|
      # row.each_with_index do |element, x_index|
      #   if ((y_index - row_index).abs <= 1) and ((x_index - col_index).abs <= 1)
      #     if (y_index == row_index) and (x_index == col_index)
      #       #do nothing
      #     elsif element == target
      #       neighbors << [y_index, x_index]
      #     end
      #   end
      # end
      neighbors << find_neighbors_each_row(row, y_index)
    end
    neighbors.size
  end

  private

  def find_neighbors_each_row(row, y_index)
    neighbors = []
    row.each_with_index do |element, x_index|
      if ((y_index - row_index).abs <= 1) and ((x_index - col_index).abs <= 1)
        if (y_index == row_index) and (x_index == col_index)
          #do nothing
        elsif element == target
          neighbors << [y_index, x_index]
        end
      end
    end
    neighbors
  end
  

  
end