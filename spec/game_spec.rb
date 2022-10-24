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

      expect(game.first_comp_coord).to be_a String

      first_cell = game.first_comp_coord
      second_cell = game.first_comp_coord
      third_cell = game.first_comp_coord

      expect(second_cell != first_cell).to be true
      expect(second_cell != third_cell).to be true
      expect(game.comp_board.array_of_coordinates.length).to eq 12
    end
  end

  describe '#find_first_comp_coord' do
    it 'finds the first empty coordinate' do
      game = Game.new
      first_cell = game.find_first_comp_coord

      expect(game.comp_board.cells[first_cell].empty?).to be true
    end
  end

  describe '#adjacent_cell?' do
    it 'finds an adjacent cell next to the empty coordinate' do
      game = Game.new

      expect(game.adjacent_cell?("A3")).to be(true).or be(false)
    end
  end

  describe '#adjacent_cells' do
    it 'returns an array of cells adjacent to the first_coord' do
      game = Game.new
      require "pry"; binding.pry
      expect(game.adjacent_cells).to be_a Array
      expect(game.adjacent_cells.length).to eq(2).or eq(3).or eq(4)

    end
  end
end
