require 'game'

describe Game do
  let(:grid) { double :grid }
  let(:player1) { double(:player1, ships_coordinates: {}, shots_coordinates: { hit: [], miss: []}) }
  let(:player2) { double(:player2, ships_coordinates: {}, shots_coordinates: { hit: [], miss: []}) }
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
      allow(grid).to receive(:print_grid1)
      expect(game).to receive(:input_coordinates).exactly(Game::SHIPS.length).times
      game.position_ships(player1)
    end

    it 'prints a new grid with every new ship added' do      
      expect(grid).to receive(:print_grid1).exactly(Game::SHIPS.length).times
      allow(game).to receive(:gets).and_return('B10 horizontal')
      game.position_ships(player1)
    end
    # improve these tests to eq the correct output
    context 'horizontal coordinates' do
      it 'adds ships and coordinates to coordinates instance variable' do
        allow(grid).to receive(:print_grid1)
        allow(game).to receive(:gets).and_return('B10 horizontal')
        expect(player1).to receive(:ships_coordinates)
        game.position_ships(player1)
      end
    end
    context 'vertical coordinates' do
      it 'adds ships and coordinates to coordinates instance variable' do
        allow(grid).to receive(:print_grid1)
        allow(game).to receive(:gets).and_return('C1 vertical')
        expect(player1).to receive(:ships_coordinates)
        game.position_ships(player1)
      end
    end
  end

  describe '#play_screen' do
    it 'prints both grids' do
      expect(grid).to receive(:print_grid2)
      expect(grid).to receive(:print_grid1)
      game.play_screen(player1)
    end
  end

  describe '#fire_shot' do
    it 'ask for shot coordinate' do
      expect(STDOUT).to receive(:puts).with 'Enter shot coordinate:'
      allow(game).to receive(:gets).and_return 'E5'
      game.fire_shot(player1, player2)
    end
    
    it "prints hit when shot hits opponent's ship" do
      allow(player2).to receive(:ships_coordinates).and_return({ destroyer: ['B2', 'E2']})
      allow(game).to receive(:gets).and_return 'B2'
      expect(STDOUT).to receive(:puts).with 'HIT!'
      game.fire_shot(player1, player2)
    end

    it "prints miss when shot miss opponent's ship" do
      allow(player2).to receive(:ships_coordinates).and_return({ destroyer: ['B2', 'E2']})
      allow(game).to receive(:gets).and_return 'A2'
      expect(STDOUT).to receive(:puts).with 'MISS!'
      game.fire_shot(player1, player2)
    end
  end
end
