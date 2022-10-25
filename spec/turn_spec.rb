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
      expect(player_board.array_of_coordinates).to include(turn.computer_aims)
      turn.computer_aims
      expect(turn.player_board.cells[turn.computers_shot].view).to eq(".")
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
    it 'can change the players board after computer fires' do
      comp_board = Board.new
      player_board = Board.new
      turn = Turn.new("A1", comp_board, player_board)

      expect(player_board.render).not_to include("M")

      turn.computer_fires
      expect(player_board.render).to include("M").once
      expect(player_board.render).not_to include("X")
    end

    it 'can hit a ship on the players board' do
      comp_board = Board.new
      player_board = Board.new
      cruiser_1 = Ship.new("Cruiser", 3)
      cruiser_2 = Ship.new("Cruiser", 3)
      cruiser_3 = Ship.new("Cruiser", 3)
      cruiser_4 = Ship.new("Cruiser", 3)
      submarine_1 = Ship.new("Submarine", 2)
      submarine_2 = Ship.new("Submarine", 2)

      expect(player_board.render).not_to include("M")
      expect(player_board.render).not_to include("X")
      expect(player_board.render).not_to include("H")

      player_board.place(cruiser_1, ["A1", "A2", "A3"])
      player_board.place(cruiser_2, ["B1", "B2", "B3"])
      player_board.place(cruiser_3, ["C1", "C2", "C3"])
      player_board.place(cruiser_4, ["D1", "D2", "D3"])
      player_board.place(submarine_1, ["A4", "B4"])
      player_board.place(submarine_2, ["C4", "D4"])
      turn = Turn.new("A1", comp_board, player_board)

      turn.computer_fires
      expect(player_board.render).to include("H")
    end
  end

  describe '#comp_feedback' do
    it 'tells the player results of the computers shot' do
      comp_board = Board.new
      player_board = Board.new
      cruiser_1 = Ship.new("Cruiser", 3)
      cruiser_2 = Ship.new("Cruiser", 3)
      cruiser_3 = Ship.new("Cruiser", 3)
      cruiser_4 = Ship.new("Cruiser", 3)
      submarine_1 = Ship.new("Submarine", 2)
      submarine_2 = Ship.new("Submarine", 2)

      player_board.place(cruiser_1, ["A1", "A2", "A3"])
      player_board.place(cruiser_2, ["B1", "B2", "B3"])
      player_board.place(cruiser_3, ["C1", "C2", "C3"])
      player_board.place(cruiser_4, ["D1", "D2", "D3"])
      player_board.place(submarine_1, ["A4", "B4"])
      player_board.place(submarine_2, ["C4", "D4"])
      turn = Turn.new("A1", comp_board, player_board)

      turn.computer_fires
      player_board.render
      expect(turn.comp_feedback).to include("was a hit!")
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
end
