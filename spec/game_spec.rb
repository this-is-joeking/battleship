require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'
require './lib/game'

describe Game do
  describe '#find_first_comp_coord' do
    it 'finds the first empty coordinate' do
      game = Game.new
      first_cell = game.find_first_comp_coord
      second_cell = game.find_first_comp_coord
      third_cell = game.find_first_comp_coord

      expect(game.comp_board.cells[first_cell].empty?).to eq true
      # expect(second_cell.empty?).to eq true
    end
  end

  # describe '#adjacent_cell' do
  #   xit 'finds an adjacent cell next to the empty coordinate' do
  #
  #   expect()
  # end
end
