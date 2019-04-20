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
end
