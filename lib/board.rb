class Board
attr_reader :cells,
            :array_of_coordinates

  def initialize
    @cells = Hash.new(false)
    @board_height = 4
    @board_width = 4
    @array_of_coordinates = []
    @width_nums = []
    @length_letters = []
    cell_maker
  end

  def cell_maker
    # sets array of nums and letters to potentially be used extend for coordinates
    alphabet = ('A'..'Z').to_a
    numbers = ('1'..'26').to_a
    # sets the arrays of nums/letters to be used for coordinates
    @width_nums = numbers.first(@board_width)
    @length_letters = alphabet.first(@board_height)
    # iterate through the num and letter arrays to build array of coordinates
    @length_letters.each do |letter|
      @width_nums.each do |num|
        @array_of_coordinates << letter + num
      end
    end
    # turn the array of coordinates into hash where key is coordinate and
    # value is the cell
    @array_of_coordinates.each do |location|
      @cells[location] = Cell.new(location)
    end
    @cells
  end

  def valid_coordinate?(location)
    if @cells[location] == false
      false
    else
      true
    end
  end

  def place_alph(placement)
    placement.map do |location|
      location[0]
    end
  end

  def place_num(placement)
    placement.map do |location|
      location[1].to_i
    end
  end

  def valid_placement?(ship, placement)
    # build array of num array pairs
    num_pairs = place_num(placement).each_cons(2).to_a
    # create array checking each pair is consecutive
    num_pairs_cons = num_pairs.map do |pair|
      if pair[0] + 1 == pair[1]
        true
      else
        false
      end
    end
    # turn num pairs into single bool confiriming if place_num is consecutive
    nums_are_cons = if num_pairs_cons.uniq == [true]
      true
    else
      false
    end
    # build array of letter pairs
    alph_pairs = place_alph(placement).each_cons(2).to_a
    # create array checking each pair of letters is consecutive
    alph_pairs_cons = alph_pairs.map do |pair|
      if pair[0].ord + 1 == pair[1].ord
        true
      else
        false
      end
    end
    # turn alph pairs into single bool confiriming if place_alpha is consecutive
    alphas_are_cons = if (alph_pairs_cons.uniq == [true])
      true
    else
      false
    end
    # check to make sure all placements are empty
    is_empty_location = placement.each do |cell|
      if @cells[cell].empty? == false
        return false
      end
    end
    # take this branch if ship size doesn't match num of coordinates
    if ship.length != placement.length || !is_empty_location
      false
    # take this branch if all the letters are the same
    elsif place_alph(placement).uniq.length == 1
        nums_are_cons
      # take this branch if all nums are same
    elsif place_num(placement).uniq.length == 1
        alphas_are_cons
      else
        false
    end
  end

  def place(ship, location)
    location.each do |cell|
      @cells[cell].place_ship(ship)
    end
  end

  def render(view_ships = false)
    board_visual = "  "
    # iterate through our cell hash and render each cells
    # every 4 cells do a new line and enter the appropriate letter first
    # first print out column header nums and new line
    @width_nums.each do |num|
      board_visual += "#{num} "
    end
    board_visual += "\n"
    counter = 0
    # print letter and 4 cells new line repeat for each letter
    @length_letters.each do |letter|
      board_visual += "#{letter} "
      @board_width.times do
        # access the array of coordinates take that to access the key in the Hash
        # access the @view in the cell of that coordinate
        cell_key = @array_of_coordinates[counter]
        board_visual += "#{@cells[cell_key].render(view_ships)} "
        counter += 1
      end
      board_visual += "\n"
    end
    board_visual
  end
end
