module Navigation
  def gen_random_indices(board_size)
    row = Random.rand(0...board_size)
    col = Random.rand(0...board_size)
    return row, col
  end

end