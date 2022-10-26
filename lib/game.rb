class Game
  attr_reader :comp_board,
              :first_coord,
              :input

  def initialize
    @comp_board = Board.new
    @player_board = Board.new

    @cruiser_comp = Ship.new("Cruiser", 3)
    @submarine_comp = Ship.new("Submarine", 2)
    @cruiser_player = Ship.new("Cruiser", 3)
    @submarine_player = Ship.new("Submarine", 2)

    @first_coord = ""
    @input = ""

    @players_shot = ""
  end

  def menu
    puts "WELCOME TO BATTLESHIP"
    puts "Enter p to play. Enter q if you are a quitter"
    @input = gets.chomp.downcase

    while input != "p" && input != "q"
      puts "Mind your ps and qs. Try again"
      puts "Enter p to play. Enter q if you are a quitter"
      @input = gets.chomp.downcase
    end
  end

  def start
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render
  end

  def first_comp_coord
    possible_first_coord = @comp_board.array_of_coordinates.shuffle
    @first_coord = possible_first_coord.pop
    while comp_board.cells[@first_coord].empty? == false
      @first_coord = possible_first_coord.pop
    end
    @first_coord
  end

  def adjacent_cell?(cell)
    @comp_board.valid_placement?(@submarine_comp, [@first_coord, cell].sort)
  end

  def adjacent_cells
    adjacent_array = @comp_board.array_of_coordinates.map do |cell|
      if adjacent_cell?(cell) == true
        cell
      end
    end
    adjacent_array.compact!
  end

  def third_adjacent_cell?(cell2, cell3)
    @comp_board.valid_placement?(@cruiser_comp, [@first_coord, cell2, cell3].sort)
  end

  def three_adjacent_cells
    array_of_placements = []
    adjacent_cells.each do |cell2|
      @comp_board.array_of_coordinates.each do |cell3|
        if third_adjacent_cell?(cell2, cell3) == true
          array_of_placements<< [@first_coord, cell2, cell3].sort
        end
      end
    end
    array_of_placements.uniq
  end

  def place_comp_cruiser
    comp_board.place(@cruiser_comp, three_adjacent_cells.sample)
    first_comp_coord
  end

  def two_adjacent_cells
    array_of_placements = []
    adjacent_cells.each do |cell|
      array_of_placements << [@first_coord, cell].sort
    end
    array_of_placements
  end

  def place_comp_sub
    comp_board.place(@submarine_comp, two_adjacent_cells.sample)
    first_comp_coord
  end

  def place_comp_ships
    first_comp_coord
    place_comp_sub
    place_comp_cruiser
  end

  def setup_cruiser
    puts "Enter the squares for the Cruiser (3 spaces):"
    cruiser_location = gets.chomp.upcase.split
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
    sub_location = gets.chomp.upcase.split
    while @player_board.valid_placement?(@submarine_player, sub_location) != true
      puts "Those are invalid :( please try again and keep consecutive"
      puts "Enter the squares for the Submarine (2 spaces):"
      sub_location = gets.chomp.upcase.split
    end
    @player_board.place(@submarine_player, sub_location)
    puts @player_board.render(true)
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @comp_board.render
    puts "===============YOUR BOARD==============="
    puts @player_board.render(true)
  end

  def get_players_shot
    puts "Enter the coordinate for your shot:"
    @players_shot = gets.chomp.upcase
  end

  def invalid_player_shot
    @comp_board.valid_coordinate?(@players_shot) == false
  end

  def duplicate_player_shot
    @comp_board.cells[@players_shot].has_been_fired_upon
  end

  def check_player_shot
    while invalid_player_shot || duplicate_player_shot
      if invalid_player_shot
        puts "That shots not gonna work... Try something on the board"
      elsif duplicate_player_shot
        puts "You've already shot here! Try a new spot"
      end
      get_players_shot
    end
  end

  def take_turn
    get_players_shot
    check_player_shot
    turn = Turn.new(@players_shot, @comp_board, @player_board)
    turn.shots_fired
    display_boards
    turn.feedback
  end

  def comp_ships_sunk?
    @cruiser_comp.sunk? && @submarine_comp.sunk?
  end

  def player_ships_sunk?
    @cruiser_player.sunk? && @submarine_player.sunk?
  end

  def game_over?
    player_ships_sunk? == true || comp_ships_sunk? == true
  end

  def winner_is
    if player_ships_sunk? && comp_ships_sunk?
      puts "We tied!"
    elsif player_ships_sunk?
      puts "I won (you lose)"
    elsif comp_ships_sunk?
      puts "You won! Congrats"
    end
    menu
  end
end
