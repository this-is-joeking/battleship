class Board
attr_reader :cells

  def initialize
    @cells = Hash.new(false)
    cell_maker
  end

  def cell_maker
    board_height = 4
    board_width = 4
    # sets array of nums and letters to potentially be used extend for coordinates
    alphabet = ('A'..'Z').to_a
    numbers = ('1'..'26').to_a
    array_of_coordinates = []
    # sets the arrays of nums/letters to be used for coordinates
    width_nums = numbers.first(board_width)
    length_letters = alphabet.first(board_height)
    # iterate through the num and letter arrays to build array of coordinates
    length_letters.each do |letter|
      width_nums.each do |num|
        array_of_coordinates << letter + num
      end
    end
    # turn the array of coordinates into hash where key is coordinate and
    # value is the cell
    array_of_coordinates.each do |location|
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

  def valid_placement?(ship, placement)
    place_alph = placement.map do |location|
      location[0]
    end
    place_num = placement.map do |location|
      location[1].to_i
    end
    # build array of num array pairs
    num_pairs = place_num.each_cons(2).to_a
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
    alph_pairs = place_alph.each_cons(2).to_a
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
    # take this branch if ship size doesn't match num of coordinates
    if ship.length != placement.length
      false
    # take this branch if all the letters are the same
    elsif place_alph.uniq.length == 1
      nums_are_cons
    # take this branch if all nums are same
    elsif place_num.uniq.length == 1
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
end
