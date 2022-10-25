require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'
require './lib/game'

describe Game do
  it 'exists' do
    game = Game.new

    expect(game).to be_a Game
  end

  describe '#first_comp_coord' do
    it 'gives a string that is a location on the board' do
      game = Game.new
      game.first_comp_coord
      first_coord = game.first_coord

      expect(game.first_comp_coord).to be_a String
      expect(game.comp_board.cells[first_coord]).to be_a Cell
    end
  end

  describe '#adjacent_cell?' do
    it 'finds an adjacent cell next to the first coordinate' do
      game = Game.new
      game.first_comp_coord

      expect(game.adjacent_cell?("A3")).to be(true).or be(false)
    end
  end

  describe '#adjacent_cells' do
    it 'returns an array of cells adjacent to the first_coord' do
      game = Game.new
      game.first_comp_coord

      expect(game.adjacent_cells).to be_a Array
      expect(game.adjacent_cells.length).to eq(2).or eq(3).or eq(4)
    end
  end

  describe '#third_adjacent_cell?' do
    it 'finds an adjacent cell next to the first 2 adjacent cells' do
      game = Game.new
      game.first_comp_coord

      expect(game.third_adjacent_cell?("A3", "A4")).to be(true).or be(false)
    end
  end

end
