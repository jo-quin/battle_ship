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

  describe '#position_ships_instructions' do
    it 'pretty-print instructions for ships positioning' do
      instructions = 'To position your ships on the grid enter starting coordinates (A to J and 1 to 10) and vertical or horizontal.
EXAMPLE: B5 vertical'
      expect(STDOUT).to receive(:puts).with instructions
      game.position_ships_instructions
    end
  end

  describe '#input_coordinates' do
    it 'calls ships_coordinates with the ship and coordinates' do
      allow(game).to receive(:gets).and_return('B5 vertical')
      expect(game).to receive(:ships_coordinates).with(:carrier, 'B5 vertical')
      game.input_coordinates(:carrier)
    end
  end

  describe '#position_ships' do
    it 'pretty-print ships positioned and ships left to be positioned'

    it 'calls ships_coordinates' do
      expect(game).to receive(:input_coordinates).once
      game.position_ships
    end
  end

  describe '#ships_coordinates' do
    it 'creates a dictionary with ships names and their position on the grid' do
      game.ships_coordinates(:carrier, 'B3 vertical')
      game.ships_coordinates(:battleship, 'A1 horizontal')
      expect(game.coordinates).to eq({ carrier: ['B3', 'B4', 'B5', 'B6', 'B7'],
      battleship: ['A1', 'B1', 'C1', 'D1'] })
    end
  end
end
