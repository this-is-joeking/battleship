require 'rspec'
require './lib/ship'
require './lib/cell'

describe Cell do
  #Test the class exists and can be initiated
  it 'exists' do
    cell = Cell.new("A3")

    expect(cell).to be_a Cell
  end

  it 'returns the assigned coordinate' do
    cell = Cell.new("B1")

    expect(cell.coordinate).to eq("B1")
  end

  it 'starts as an empy cell not holding a ship' do
    cell = Cell.new("D2")

    expect(cell.ship).to eq nil
  end

  describe '#empty?' do
    it 'can confirm if the cell is empty' do
      cell = Cell.new("D2")

      expect(cell.empty?).to eq true
    end

    it 'can confirm if the cell is not empty' do
      cell = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.empty?).to eq false
    end
  end

  describe '#place_ship' do
    it 'can have a ship placed in a cell' do
      cell = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.ship).to be_a Ship
    end
  end

  describe '#fired_upon?' do
    it 'confirms if it has not been fired upon' do
      cell = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.fired_upon?).to eq false
    end

    it 'confirms if it has been fired upon' do
      cell = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      cell.fire_upon

      expect(cell.fired_upon).to eq true
    end
  end

  describe '#fire_upon' do
    it 'makes the ship in the cell take a hit' do
      cell = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.ship.health).to eq 3

      cell.fire_upon 

      expect(cell.ship.health).to eq 2
    end
  end
end
