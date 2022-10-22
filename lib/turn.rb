class Turn
  attr_reader :comp_board,
              :player_board

  def initialize(cell, comp_board, player_board)
    @cell = cell
    @comp_board = comp_board
    @player_board = player_board
    @computers_shot = nil
  end

  def computer_aims
    computers_potential_shots = @player_board.array_of_coordinates.shuffle
    @computers_shot = computers_potential_shots.pop
    "A1"
    # ^^^ this is used for testing computers cell selection
  end

  def player_fires
    @comp_board.cells[@cell].fire_upon
  end

  def computer_fires
    @player_board.cells[computer_aims].fire_upon
  end

  # tell the player what happened hits/misses

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts comp_board.render
    puts "===============YOUR BOARD==============="
    puts player_board.render(true)
  end


end
