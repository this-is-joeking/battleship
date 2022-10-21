require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'

describe Turn do
  it 'exists' do
    comp_board = Board.new
    player_board = Board.new
    turn = Turn.new("A1", comp_board, player_board)

    expect(turn).to be_a Turn
  end

  it 'generates computers shot' do
    comp_board = Board.new
    player_board = Board.new
    turn = Turn.new("A1", comp_board, player_board)

    expect(turn.computer_fires).to be_a String
  end
end

# Will need to take coordinate from player & coordinate
# from computer

# Will need to check if valid placements (prompt again if
# invalid space)

# Player turn- user inputs cell

# Computer turn- choose random cell (shuffle.pop)

# Respond with results of shot
