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
end
