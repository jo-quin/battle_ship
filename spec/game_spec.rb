require 'game'

describe Game do
  let(:grid) { double :grid }
  subject(:game) { Game.new(grid) }

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
    it 'calls ships_coordinates' do
      allow(grid).to receive(:print_grid)
      expect(game).to receive(:input_coordinates).exactly(Game::SHIPS.length).times
      game.position_ships
    end

    it 'prints a new grid with every new ship added' do      
      expect(grid).to receive(:print_grid).exactly(Game::SHIPS.length).times
      allow(game).to receive(:gets).and_return('B5 horizontal')
      game.position_ships
    end
    # improve these tests to eq the correct output
    context 'horizontal coordinates' do
      it 'adds ships and coordinates to coordinates instance variable' do
        allow(grid).to receive(:print_grid)
        allow(game).to receive(:gets).and_return('B5 horizontal')
        expect{ game.position_ships }.to change{ game.ships_coordinates }
      end
    end
    context 'vertical coordinates' do
      it 'adds ships and coordinates to coordinates instance variable' do
        allow(grid).to receive(:print_grid)
        allow(game).to receive(:gets).and_return('C3 vertical')
        expect{ game.position_ships }.to change{ game.ships_coordinates }
      end
    end
  end

  describe '#play_screen' do
    it 'prints both grids' do
      expect(grid).to receive(:print_grid).twice
      game.play_screen
    end
  end

  describe '#fire_shot' do
    it 'ask for shot coordinate' do
      expect(STDOUT).to receive(:puts).with 'Enter shot coordinate:'
      allow(game).to receive(:gets).and_return 'E5'
      game.fire_shot
    end

    it 'prints the grid with the shot coordinate marked with an X' # should expect to call print grid

    it 'prints hit or miss'
  end
end
