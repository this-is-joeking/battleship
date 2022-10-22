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
    # @computers_shot = "A1"
    # ^^^ this is used for testing computers cell selection
  end

  def player_fires
    @comp_board.cells[@cell].fire_upon
  end

  def computer_fires
    @player_board.cells[computer_aims].fire_upon
  end

  def comp_feedback
    comp_result = player_board.cells[@computers_shot].view
    if comp_result == "M"
      p "The computer shot on #{@computers_shot} was a big fat miss."
    elsif comp_result == "H"
      p "The computer shot on #{@computers_shot} was a hit!"
    elsif comp_result == "X"
      p "The computer shot on #{@computers_shot} sunk one of your ships!"
    else
      p "ERROR"
    end
  end

  def player_feedback
    player_result = comp_board.cells[@cell].view
    if player_result == "M"
      p "Your shot on #{@cell} was a big fat miss."
    elsif player_result == "H"
      p "Your shot on #{@cell} was a hit!"
    elsif player_result == "X"
      p "Your shot on #{@cell} sunk one of the computers ships!"
    else
      p "ERROR"
    end
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts comp_board.render
    puts "===============YOUR BOARD==============="
    puts player_board.render(true)
  end
end
