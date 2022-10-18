require 'rspec'
require './lib/ship'
require './lib/cell'

describe Cell do
  #Test the class exists and can be initiated
  it 'exists' do
    cell = Cell.new("A3")

    expect(cell).to be_a Cell
  end

  describe '#coordinate' do
    it 'returns the assigned coordinate' do
      cell = Cell.new("B1")

      expect(cell.coordinate).to eq("B1")
    end
  end

end
