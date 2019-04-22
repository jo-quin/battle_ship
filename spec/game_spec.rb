require 'game'

describe Game do
  subject(:game) { Game.new }

  describe '#ships' do
    it 'pretty-print the ships and their length' do
      ships = 'Carrier Length: 5
Battleship Length: 4
Cruiser Length: 3
Submarine Length: 3
Destroyer Length: 2
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

  describe '#position_ships' do
    it 'pretty-print ships positioned and ships left to be positioned'

    it 'prints a new grid with every new ship added'

    it 'calls ships_coordinates' do
      expect(game).to receive(:input_coordinates).exactly(Game::SHIPS.length).times
      game.position_ships
    end

    context 'horizontal coordinates' do
      it 'adds ships and coordinates to coordinates instance variable' do
        allow(game).to receive(:gets).and_return('B5 horizontal')
        expect{ game.position_ships }.to change{ game.coordinates }
        puts game.coordinates
      end
    end
    context 'vertical coordinates' do
      it 'adds ships and coordinates to coordinates instance variable' do
        allow(game).to receive(:gets).and_return('C3 vertical')
        expect{ game.position_ships }.to change{ game.coordinates }
        puts game.coordinates
      end
    end

  end
end
