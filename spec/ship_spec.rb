require 'rspec'
require './lib/ship'

RSpec.describe Ship do
  it 'exits' do
    cruiser = Ship.new("Cruiser", 3)
    battleship = Ship.new("Battleship", 4)
    destroyer = Ship.new("Destroyer", 2)

    expect(cruiser).to be_instance_of(Ship)
    expect(battleship).to be_instance_of(Ship)
    expect(destroyer).to be_instance_of(Ship)
  end

  it 'has a name' do
    cruiser = Ship.new("Cruiser", 3)
    battleship = Ship.new("Battleship", 4)
    destroyer = Ship.new("Destroyer", 2)

    expect(cruiser.name).to eq("Cruiser")
    expect(battleship.name).to eq("Battleship")
    expect(destroyer.name).to eq("Destroyer")
  end

  it 'has length' do
    cruiser = Ship.new("Cruiser", 3)
    battleship = Ship.new("Battleship", 4)
    destroyer = Ship.new("Destroyer", 2)

    expect(cruiser.length).to eq(3)
    expect(battleship.length).to eq(4)
    expect(destroyer.length).to eq(2)
  end

  it 'has health' do
    cruiser = Ship.new("Cruiser", 3)
    battleship = Ship.new("Battleship", 4)

    expect(cruiser.health).to eq(3)
    expect(battleship.health).to eq(4)
  end

  describe '#hit' do
    it 'reduces health' do
      cruiser = Ship.new("Cruiser", 3)
      battleship = Ship.new("Battleship", 4)

      cruiser.hit
      battleship.hit

      expect(cruiser.health).to eq(2)
      expect(battleship.health).to eq(3)

      cruiser.hit
      battleship.hit

      expect(cruiser.health).to eq(1)
      expect(battleship.health).to eq(2)
    end
  end

  # Test is sunk when hits equal health
  it 'is sunk' do
    cruiser = Ship.new("Cruiser", 3)
    battleship = Ship.new("Battleship", 4)

    cruiser.hit
    battleship.hit

    expect(cruiser.sunk?).to be false
    expect(battleship.sunk?).to be false
  end

  it 'is sunk' do
    cruiser = Ship.new("Cruiser", 3)
    battleship = Ship.new("Battleship", 4)

    cruiser.hit
    cruiser.hit
    cruiser.hit

    battleship.hit
    battleship.hit
    battleship.hit
    battleship.hit

    expect(cruiser.sunk?).to be true
    expect(battleship.sunk?).to be true
  end
end
