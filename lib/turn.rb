class Turn
  attr_reader :comp_board,
              :player_board
              
  def initialize(cell, comp_board, player_board)
    @cell = cell
    @comp_board = comp_board
    @player_board = player_board
  end

  def computer_aims
    @player_board.array_of_coordinates.shuffle!.pop
  end

  def player_fires
    @comp_board.cells[@cell].fire_upon
  end

end
