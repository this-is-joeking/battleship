class Cell
  attr_reader :coordinate, :ship, :view

  def initialize(location)
    @coordinate = location
    @ship = nil
    @view = "."
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship_arg)
    @ship = ship_arg
  end

  def fired_upon?
    ship.health != ship.length
  end

  def fire_upon
    if @ship.nil?
      @view = "M"
    elsif ship.hit
      if ship.sunk?
        @view = "X"
      else
        @view = "H"
      end
    end
  end

  def render
    p @view
  end
end
