class Game

  def initialize
    # creates boards
    @comp_board = Board.new
    @player_board = Board.new

    # creates ships
    @cruiser_comp = Ship.new("Cruiser", 3)
    @submarine_comp = Ship.new("Submarine", 2)
    @cruiser_player = Ship.new("Cruiser", 3)
    @submarine_player = Ship.new("Submarine", 2)
  end


  def start
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render
  end

  def find_first_comp_coord
    comp_ship = @comp_board.array_of_coordinates.shuffle.pop
    while !@comp_board.cells[comp_ship].empty?
      comp_ship = @comp_board.array_of_coordinates.pop
    end
    @comp_board.cells[comp_ship]
  end

# look for next adjacent, consecutive cell


  def setup_cruiser
    puts "Enter the squares for the Cruiser (3 spaces):"
    cruiser_location = gets.chomp.split
    while @player_board.valid_placement?(@cruiser_player, cruiser_location) != true
      puts "Those are invalid :( please try again and keep consecutive"
      puts "Enter the squares for the Cruiser (3 spaces):"
      cruiser_location = gets.chomp.upcase.split
    end
    @player_board.place(@cruiser_player, cruiser_location)
    puts @player_board.render(true)
  end

  def setup_sub
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

  # Next we need to show the boards
  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @comp_board.render
    puts "===============YOUR BOARD==============="
    puts @player_board.render(true)
  end

  def take_turn
    puts "Enter the coordinate for your shot:"
    players_shot = gets.chomp
    while @comp_board.valid_coordinate?(players_shot) == false
      puts "That shots not gonna work..."
      puts "Enter the coordinate for your shot:"
      players_shot = gets.chomp
    end
    turn = Turn.new(players_shot, @comp_board, @player_board)

  end

end
