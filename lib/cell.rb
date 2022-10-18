class Cell
  attr_reader :coordinate, :ship

  def initialize(location)
    @coordinate = location
    @ship = nil
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
    ship.hit
  end
end
