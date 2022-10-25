require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'

describe Board do
  it 'exists' do
    board = Board.new

    expect(board).to be_a Board
  end

  it 'holds a hash of 16 cells' do
    board = Board.new

    expect(board.cells).to be_a Hash
    expect(board.cells.length).to eq 16
    expect(board.cells["A1"]).to be_a Cell
    expect(board.cells["D4"]).to be_a Cell
    expect(board.cells["A5"]).to eq false
  end

  describe '#alphabet' do
    it 'creates an array of the alphabet' do
      board = Board.new

      expect(board.alphabet).to eq([ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L',
        'M', 'N', 'O', 'P', 'Q', 'R',  'S', 'T', 'U', 'V', 'W', 'X',
        'Y', 'Z' ])
    end
  end

  describe '#numbers' do
    it 'creates an array of numbers' do
      board = Board.new

      expect(board.numbers).to eq (['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26'])
    end
  end

  describe '#width_nums' do
    it 'creates array of nums to be used in coordinates' do
      board = Board.new

      expect(board.width_nums).to eq(['1', '2', '3', '4'])
    end
  end

  describe '#length_letters' do
    it 'creates array of letters to be used in coordinates' do
      board = Board.new

      expect(board.length_letters).to eq(['A', 'B', 'C', 'D'])
    end
  end

  describe '#valid_coordinate?' do
    it 'validates a coordinate' do
      board = Board.new

      expect(board.valid_coordinate?("A1")).to be true
      expect(board.valid_coordinate?("D4")).to be true
      expect(board.valid_coordinate?("A5")).to be false
      expect(board.valid_coordinate?("E1")).to be false
    end
  end

  describe '#place_alph' do
    it 'it splits coordinate by first location in string' do
      board = Board.new

      expect(board.place_alph(["A1", "A2", "A3"])).to eq(["A", "A", "A"])
    end
  end

  describe '#place_num' do
    it 'it splits coordinate by second locaiton in string' do
      board = Board.new

      expect(board.place_num(["A1", "A2", "A3"])).to eq([1, 2, 3])
    end
  end

  describe '#valid_placement?' do
    it 'validates length of the ship' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be false
      expect(board.valid_placement?(submarine, ["A2", "A3"])).to be true
    end

    it 'validates coordinates are consecutive' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
      expect(board.valid_placement?(submarine, ["A2", "C1"])).to be false
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be false
      expect(board.valid_placement?(submarine, ["B1", "B2"])).to be true
    end

    it 'does not let coordinates be diagonal' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
      expect(board.valid_placement?(submarine, ["C2", "D3"])).to be false
    end

    it 'confirm placements are valid' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(submarine, ["A1", "A2"])).to be true
      expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be true
    end

    it 'checks to see if there is already ship in the cell(s)' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be true
      board.place(cruiser, ['A1', 'A2', 'A3'])

      expect(board.valid_placement?(submarine, ["A1", "A2"])).to be false
      expect(board.valid_placement?(submarine, ["B1", "B2"])).to be true
    end
  end

  describe '#place' do
    it 'can place a ship on cells' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      expect(cell_1.ship).to be_a(Ship)
      expect(cell_2.ship).to be_a(Ship)
      expect(cell_3.ship).to be_a(Ship)
    end

    it 'can hold same ship in multiple cells' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      expect(cell_3.ship == cell_2.ship).to eq(true)
    end
  end

  describe '#render' do
    it 'prints a visual of the board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.render).to eq(
        "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
      expect(board.render(true)).to eq(
        "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it 'can render visual of board with hits/misses' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      board.cells["A1"].fire_upon

      expect(board.render).to eq(
        "  1 2 3 4 \nA H . . . \nB . . . . \nC . . . . \nD . . . . \n")

      board.cells["A2"].fire_upon
      board.cells["A3"].fire_upon
      board.cells["D1"].fire_upon
      expect(board.render).to eq(
        "  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD M . . . \n")
    end

    it 'can render visual of board with multiple hits/misses/sink' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      board.place(cruiser, ["A1", "A2", "A3"])
      board.place(submarine, ["C3", "D3"])
      board.cells["A1"].fire_upon
      board.cells["A2"].fire_upon
      board.cells["A3"].fire_upon
      board.cells["D1"].fire_upon
      board.cells["D3"].fire_upon

      expect(board.render).to eq(
        "  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD M . H . \n")
      expect(board.render(true)).to eq(
        "  1 2 3 4 \nA X X X . \nB . . . . \nC . . S . \nD M . H . \n")
    end
  end
end
