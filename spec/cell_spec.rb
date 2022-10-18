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

  it 'can confirm if the cell is empty' do
    cell = Cell.new("D2")

    expect(cell.empty?).to eq true
  end

end
