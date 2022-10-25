class Board
  attr_reader :cells,
              :array_of_coordinates

  def initialize
    @cells = Hash.new(false)
    @board_height = 4
    @board_width = 4
    @array_of_coordinates = []
    cell_maker
  end

  def alphabet
    ('A'..'Z').to_a
  end

  def numbers
    ('1'..'26').to_a
  end

  def width_nums
    numbers.first(@board_width)
  end

  def length_letters
    alphabet.first(@board_height)
  end

  def cell_maker
    length_letters.each do |letter|
      width_nums.each do |num|
        @array_of_coordinates << letter + num
      end
    end
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

  def num_pairs(placement)
    place_num(placement).each_cons(2).to_a
  end

  def num_pairs_cons(placement)
    num_pairs(placement).map do |pair|
      if pair[0] + 1 == pair[1]
        true
      else
        false
      end
    end
  end

  def alph_pairs(placement)
    place_alph(placement).each_cons(2).to_a
  end

  def alph_pairs_cons(placement)
    alph_pairs(placement).map do |pair|
      if pair[0].ord + 1 == pair[1].ord
        true
      else
        false
      end
    end
  end

  def nums_are_cons?(placement)
    num_pairs_cons(placement).uniq == [true]
  end

  def alphas_are_cons?(placement)
    alph_pairs_cons(placement).uniq == [true]
  end

  def is_empty_location(placement)
    placement.each do |cell|
      if @cells[cell].empty? == false
        return false
      end
    end
  end

  def valid_coordinates?(placement)
    valid_coords = placement.map do |cell|
      if valid_coordinate?(cell) == false
        return false
      elsif valid_coordinate?(cell) == true
        true
      end
    end
    valid_coords.uniq[0]
  end

  def valid_placement?(ship, placement)
    if !valid_coordinates?(placement)
      false
    elsif ship.length != placement.length || !is_empty_location(placement)
      false
    elsif place_alph(placement).uniq.length == 1
      nums_are_cons?(placement)
    elsif place_num(placement).uniq.length == 1
      alphas_are_cons?(placement)
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
    width_nums.each do |num|
      board_visual += "#{num} "
    end
    board_visual += "\n"
    counter = 0
    length_letters.each do |letter|
      board_visual += "#{letter} "
      @board_width.times do
        cell_key = @array_of_coordinates[counter]
        board_visual += "#{@cells[cell_key].render(view_ships)} "
        counter += 1
      end
      board_visual += "\n"
    end
    board_visual
  end
end
