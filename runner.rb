require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'

# creates boards
@comp_board = Board.new
@player_board = Board.new

# creates ships
@cruiser_comp = Ship.new("Cruiser", 3)
@submarine_comp = Ship.new("Submarine", 2)
@cruiser_player = Ship.new("Cruiser", 3)
@submarine_player = Ship.new("Submarine", 2)

# places ships for computer
@comp_board.place(@cruiser_comp, ["A1", "B1", "C1"])
@comp_board.place(@submarine_comp, ["B3", "B4"])

def start
  puts "I have laid out my ships on the grid."
  puts "You now need to lay out your two ships."
  puts "The Cruiser is three units long and the Submarine is two units long."
  puts @player_board.render
  # Ask Mike about scope???
  puts "Enter the squares for the Cruiser (3 spaces):"
  cruiser_location = gets.chomp.split
  while @player_board.valid_placement?(@cruiser_player, cruiser_location) != true
    puts "Those are invalid :( please try again and keep consecutive"
    puts "Enter the squares for the Cruiser (3 spaces):"
    cruiser_location = gets.chomp.upcase.split
  end
  @player_board.place(@cruiser_player, cruiser_location)
  puts @player_board.render(true)
  puts "Enter the squares for the Submarine (2 spaces):"
  sub_location = gets.chomp.split
  while @player_board.valid_placement?(@submarine_player, sub_location) != true
    puts "Those are invalid :( please try again and keep consecutive"
    puts "Enter the squares for the Submarine (2 spaces):"
    sub_location = gets.chomp.upcase.split
  end
  @player_board.place(@submarine_player, sub_location)
  puts @player_board.render(true)
end

puts "WELCOME TO BATTLESHIP"
puts "Enter p to play. Enter q if you are a quitter"
input = gets.chomp

while input != "p" && input != "q"
  puts "Mind your ps and qs. Try again"
  puts "Enter p to play. Enter q if you are a quitter"
  input = gets.chomp
end

if input == "p"
  start
elsif input == "q"
  puts "Come back again soon :("
else
  puts "error"
end


## need to go back to valid_placement? method on board class to define what
## should happen if the input is not coordinates at all or if letters are
## downcase
