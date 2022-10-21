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

    expect(turn.computer_aims).to be_a String
  end

  it 'can take the players shot' do
    comp_board = Board.new
    player_board = Board.new
    turn = Turn.new("A1", comp_board, player_board)

    expect(turn.comp_board.cells["A1"].view).to eq(".")
    turn.player_fires
    expect(turn.comp_board.cells["A1"].view).to eq("M")
  end

  it 'can hit a ship on the board' do
    comp_board = Board.new
    player_board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    comp_board.place(cruiser, ["A1", "A2", "A3"])
    comp_board.place(submarine, ["C3", "D3"])
    turn = Turn.new("A1", comp_board, player_board)

    expect(turn.comp_board.cells["A1"].view).to eq(".")
    turn.player_fires
    expect(turn.comp_board.cells["A1"].view).to eq("H")
  end

end


# For player turn- will need to check if valid placements (prompt again if
# invalid space)

# Player turn- user inputs cell

# Computer turn- choose random cell (shuffle.pop)

# Respond with results of shot
