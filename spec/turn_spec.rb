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

  describe '#computer_aims' do
    it 'generates computers shot' do
      comp_board = Board.new
      player_board = Board.new
      turn = Turn.new("A1", comp_board, player_board)

      expect(turn.computer_aims).to be_a String
    end
  end

  describe '#player_fires' do
    it 'can take the players shot' do
      comp_board = Board.new
      player_board = Board.new
      turn = Turn.new("A1", comp_board, player_board)

      expect(turn.comp_board.cells["A1"].view).to eq(".")
      turn.player_fires
      turn.comp_board.render
      expect(turn.comp_board.cells["A1"].view).to eq("M")
    end

    it 'can hit a ship on the computers board' do
      comp_board = Board.new
      player_board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      comp_board.place(cruiser, ["A1", "A2", "A3"])
      comp_board.place(submarine, ["C3", "D3"])
      turn = Turn.new("A1", comp_board, player_board)

      expect(turn.comp_board.cells["A1"].view).to eq(".")
      turn.player_fires
      turn.comp_board.render
      expect(turn.comp_board.cells["A1"].view).to eq("H")
    end
  end

  describe '#computer_fires' do
    xit 'can take the computers shot' do
      comp_board = Board.new
      player_board = Board.new
      turn = Turn.new("A1", comp_board, player_board)

      expect(turn.player_board.cells["A1"].view).to eq(".")
      turn.computer_fires
      expect(turn.player_board.cells["A1"].view).to eq("M")
    end

    xit 'can hit a ship on the players board' do
      comp_board = Board.new
      player_board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      player_board.place(cruiser, ["A1", "A2", "A3"])
      player_board.place(submarine, ["C3", "D3"])
      turn = Turn.new("A1", comp_board, player_board)

      expect(turn.player_board.cells["A1"].view).to eq(".")
      turn.computer_fires
      expect(turn.player_board.cells["A1"].view).to eq("H")
    end
  end

  describe '#player_feedback' do
    it 'tells the player results of the players shot' do
      comp_board = Board.new
      player_board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      player_board.place(cruiser, ["A1", "A2", "A3"])
      player_board.place(submarine, ["C3", "D3"])
      comp_board.place(cruiser, ["A1", "B1", "C1"])
      comp_board.place(submarine, ["B3", "B4"])
      turn = Turn.new("A1", comp_board, player_board)
      turn.player_fires
      turn.computer_fires
      turn.comp_board.render 

      expect(turn.player_feedback).to eq("Your shot on A1 was a hit!")
    end
  end

  describe '#comp_feedback' do
    xit 'tells the player results of the computers shot' do
      comp_board = Board.new
      player_board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      player_board.place(cruiser, ["A1", "A2", "A3"])
      player_board.place(submarine, ["C3", "D3"])
      comp_board.place(cruiser, ["A1", "B1", "C1"])
      comp_board.place(submarine, ["B3", "B4"])
      turn = Turn.new("A1", comp_board, player_board)
      turn.player_fires
      turn.computer_fires

      expect(turn.comp_feedback).to eq("The computer shot on A1 was a hit!")
    end
  end
end
