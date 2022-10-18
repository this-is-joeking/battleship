class Cell
  attr_reader :coordinate, :ship

  def initialize(location)
    @coordinate = location
    @ship = nil
  end

  def empty?
    @ship == nil
  end

end
