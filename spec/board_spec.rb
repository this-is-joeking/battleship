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
  end

  it 'validates a coordinate' do
    board = Board.new
    board.cells

    expect(board.valid_coordinate?("A1")).to be true
    expect(board.valid_coordinate?("D4")).to be true
    expect(board.valid_coordinate?("A5")).to be false
    expect(board.valid_coordinate?("E1")).to be false
  end

  it 'validates length of the ship' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells

    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be false
    expect(board.valid_placement?(submarine, ["A2", "A3"])).to be true
  end

  it 'validates coordinates are consecutive' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells

    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
    expect(board.valid_placement?(submarine, ["A2", "C1"])).to be false
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be false
    expect(board.valid_placement?(submarine, ["B1", "B2"])).to be true
  end

  it 'does not let coordinates be diagonal' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells

    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to be false
  end

  it 'confirm placements are valid' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells

    expect(board.valid_placement?(submarine, ["A1", "A2"])).to be true
    expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be true
  end

  it 'can place a ship on cells' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.cell_maker
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

    board.cells
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    expect(cell_3.ship == cell_2.ship).to eq(true)
  end
end
