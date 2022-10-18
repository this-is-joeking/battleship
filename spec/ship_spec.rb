require 'rspec'
require './lib/ship'

RSpec.describe Ship do

  # Test it can create new ships
  it 'exits' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser).to be_instance_of(Ship)
  end

  # Test the ship has a name
  it 'has a name' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.name).to eq("Cruiser")
  end

  # Test the ship has length
  it 'has length' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.length).to eq(3)
  end

  # Test the ship has health (should equal the length)
  it 'has health' do
    cruiser = Ship.new("Cruiser", 3)
    # probably need more code here

    expect(cruiser.health).to eq(3)
  end

  # Test health goes down one when hit
  it 'has health' do
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit

    expect(cruiser.health).to eq(2)
  end

  # Test is sunk when hits equal health
  it 'is sunk' do
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit

    expect(cruiser.sunk?).to be false
  end

  xit 'is sunk' do
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    cruiser.hit
    cruiser.hit

    expect(cruiser.sunk?).to be true
  end
end
