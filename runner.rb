require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'
require './lib/game'


puts "WELCOME TO BATTLESHIP"
puts "Enter p to play. Enter q if you are a quitter"
input = gets.chomp

while input != "p" && input != "q"
  puts "Mind your ps and qs. Try again"
  #move the strings to a method
  puts "Enter p to play. Enter q if you are a quitter"
  input = gets.chomp.downcase
end

if input == "p"
  game = Game.new
  game.start
  game.setup_cruiser
  game.setup_sub
  game.display_boards
  game.take_turn
elsif input == "q"
  puts "Come back again soon :("
end


## need to go back to valid_placement? method on board class to define what
## should happen if the input is not coordinates at all or if letters are
## downcase
