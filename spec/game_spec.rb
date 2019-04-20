require 'game'

describe Game do
  subject(:game) { Game.new }

  describe '#ships' do
    it 'pretty-print the ships, qty and their length' do
      ships = 'Carrier Qty: 1 Length: 5
Battleship Qty: 2 Length: 4
Cruiser Qty: 3 Length: 3
Submarine Qty: 4 Length: 3
Destroyer Qty: 5 Length: 2
'
      expect(STDOUT).to receive(:puts).with ships
      game.ships
    end
  end

  describe '#position_ships' do
    it 'pretty-print instructions for ships positioning' do
      instructions = 'To position your ship enter starting coordinates (A to J and 1 to 10) and vertical or horizontal.
EXAMPLE: B5 vertical'
      expect(STDOUT).to receive(:puts).with instructions
      game.position_ships
    end

    it 'creates a dictionary with ships names and their position on the grid'

    it 'pretty-print ships positioned and ships left to be positioned'
  end
end
