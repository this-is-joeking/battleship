class Cell
  attr_reader :coordinate, :ship, :view

  def initialize(location)
    @coordinate = location
    @ship = nil
    @view = "."
    @has_been_fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship_arg)
    @ship = ship_arg
  end

  def fired_upon?
    @has_been_fired_upon
  end

  def fire_upon
    @has_been_fired_upon = true
    if !empty?
      ship.hit
    end
  end

  def render(view_ships = false)
    if @ship.nil? && !fired_upon?
      @view = "."
    elsif @ship.nil? && fired_upon?
      @view = "M"
    elsif !empty? && ship.sunk?
      @view = "X"
    elsif !empty? && !ship.sunk? && fired_upon?
      @view = "H"
    elsif view_ships == true && ! empty? && @view != "H"
      @view = "S"
    else
      @view
    end
  end
end
