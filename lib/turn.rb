class Turn

  def initialize(cell, comp_board, player_board)
    @cell = cell
    @comp_board = comp_board
    @player_board = player_board
  end

  def computer_fires
    @comp_board.array_of_coordinates.shuffle!.pop
  end
end
