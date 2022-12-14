require 'rspec'
require './lib/ship'
require './lib/cell'

describe Cell do
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

      expect(cell.ship).to eq nil
      cell.place_ship(cruiser)

      expect(cell.ship).to eq(cruiser)
    end

    it 'can have a ship placed in a cell' do
      cell = Cell.new("C3")
      submarine = Ship.new("Submarine", 2)

      expect(cell.ship).to eq nil
      cell.place_ship(submarine)

      expect(cell.ship).to eq(submarine)
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

      expect(cell.fired_upon?).to eq true
    end
  end

  describe '#fire_upon' do
    it 'decreases health' do
      cell = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.ship.health).to eq 3

      cell.fire_upon

      expect(cell.ship.health).to eq 2
    end
  end

  describe '#render' do
    it 'prints . if the cell has not been fired upon' do
      cell_1 = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell_1.place_ship(cruiser)

      expect(cell_1.render).to eq(".")
    end

    it 'prints M if the shot was a miss' do
      cell_1 = Cell.new("B4")
      cell_1.fire_upon

      expect(cell_1.render).to eq("M")
    end

    it 'prints H if the shot was hit' do
      cell_1 = Cell.new("B4")
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)

      cell_2.place_ship(cruiser)
      cell_2.fire_upon

      expect(cell_2.render).to eq("H")
    end

    it 'prints X if the ship has been fired_upon and sunk' do
      cell_1 = Cell.new("B4")
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)

      cell_2.place_ship(cruiser)
      cell_2.fire_upon
      cruiser.hit
      cruiser.hit

      expect(cell_2.render).to eq("X")
    end

    it 'reveals a ship even if not been fired upon' do
      cell_1 = Cell.new("B4")
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)

      cell_2.place_ship(cruiser)

      expect(cell_2.render(true)).to eq("S")
    end

    it 'reveals where there is not a ship if render is called with true' do
      cell_1 = Cell.new("B4")
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)

      expect(cell_2.render(true)).to eq(".")
    end
  end
end
