class Ship
  attr_reader :name,
              :length,
              :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  def hit
    @health = (health - 1)
  end

  def sunk?
    if @health >= 1
      false
    elsif @health <= 1
      true
    end
  end
end
