require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'
require './lib/game'

game = Game.new
game.menu

if game.input == "p"
  while game.input == "p"
    game = Game.new
    game.start
    game.setup_cruiser
    game.setup_sub
    game.place_comp_ships
    game.display_boards
    game.take_turn
    while game.game_over? == false
      game.take_turn
    end
    game.winner_is
  end
elsif game.input == "q"
  puts "Come back again soon :("
end
