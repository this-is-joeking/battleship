class Board
# attr_reader :cells

  def initialize
    @cell_holder = Hash.new(false)
  end

  def cells
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
      @cell_holder[location] = Cell.new(location)
    end
    @cell_holder
  end

  def valid_coordinate?(location)
    if @cell_holder[location] == false
      false
    else
      true
    end
  end

  def valid_placement?(ship, placement)
    if consecutive ==
      

      # placement.each do |location|
      #   location[0] location[1]
      end
    end
      if ship.length == placement.length
        true
      else
        false
      end
  end
end
