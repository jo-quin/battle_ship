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
      expect(game.ships).to eq(ships)
    end
  end

  describe '#position_ships' do
    it 'calls ships_coordinates' do
      allow(grid).to receive(:print_grid1)
      allow(game).to receive(:gets).and_return('B1 vertical', 'A3 vertical', 'E10 horizontal', 'J4 vertical', 'C9 horizontal')
      allow(player1).to receive(:client).and_return(i = IO.new(1))
      expect(game).to receive(:input_coordinates).exactly(Game::SHIPS.length).times
      game.position_ships(player1, player2)
    end

    it 'prints a new grid with every new ship added' do
      allow(game).to receive(:gets).and_return('B1 vertical', 'A3 vertical', 'E10 horizontal', 'J4 vertical', 'C9 horizontal')
      allow(player1).to receive(:client).and_return(i = IO.new(1))
      allow(game).to receive(:input_coordinates).exactly(Game::SHIPS.length).times
      expect(grid).to receive(:print_grid1).exactly(Game::SHIPS.length).times
      game.position_ships(player1, player2)
    end

    context 'when entering used coordinates for a new ship' do
      it 'displays and error message and asks for coordinates again' do
        allow(grid).to receive(:print_grid1)
        allow(player1).to receive(:client).and_return(i = IO.new(1))
        allow(i).to receive(:gets).and_return('B1 vertical', 'B1 vertical', 'A3 vertical', 'E10 horizontal', 'J4 vertical', 'C9 horizontal')
        expect(game).to receive(:error_message)
        game.position_ships(player1, player2)
      end
    end

    context 'when new ship is positioned outside the grid' do
      it 'displays and error message and asks for coordinates again (vertical)' do
        allow(grid).to receive(:print_grid1)
        allow(player1).to receive(:client).and_return(i = IO.new(1))
        allow(i).to receive(:gets).and_return('B10 vertical', 'B1 vertical', 'A3 vertical', 'E10 horizontal', 'J4 vertical', 'C9 horizontal')
        expect(game).to receive(:error_message)
        game.position_ships(player1, player2)
      end
      it 'displays and error message and asks for coordinates again (horizontal)' do
        allow(grid).to receive(:print_grid1)
        allow(player1).to receive(:client).and_return(i = IO.new(1))
        allow(i).to receive(:gets).and_return('J10 horizontal', 'B3 vertical','A3 vertical', 'E10 horizontal', 'J4 vertical', 'C9 horizontal')
        expect(game).to receive(:error_message)
        game.position_ships(player1, player2)
      end      
    end
  end

  describe '#play_screen' do
    it 'prints both grids' do
      expect(grid).to receive(:print_grid2)
      expect(grid).to receive(:print_grid1)
      game.play_screen(player1, player2)
    end
  end

  describe '#fire_shot' do
    it 'ask for shot coordinate' do
      allow(player1).to receive(:client).and_return(i = IO.new(1))
      allow(i).to receive(:gets).and_return('')
      game.fire_shot(player1, player2)
    end
    
    it "prints hit when shot hits opponent's ship" do
      allow(player2).to receive(:ships_coordinates).and_return({ destroyer: ['B2', 'E2']})
      allow(player1).to receive(:client).and_return(i = IO.new(1))
      allow(i).to receive(:gets).and_return('B2')
      expect(game.fire_shot(player1, player2)).to eq('HIT!')
    end

    it "prints miss when shot miss opponent's ship" do
      allow(player2).to receive(:ships_coordinates).and_return({ destroyer: ['B2', 'E2']})
      allow(player1).to receive(:client).and_return(i = IO.new(1))
      allow(i).to receive(:gets).and_return('A2')
      expect(game.fire_shot(player1, player2)).to eq('MISS!')
    end

    it 'prints SHIP SANK! when opponent hit the last coordinate of the ship' do
      allow(player2).to receive(:ships_coordinates).and_return({ destroyer: ['B2','E2'], submarine: ['A1', 'A2', 'A3']})
      allow(player1).to receive(:client).and_return(i = IO.new(1))
      allow(i).to receive(:gets).and_return('B2')
      game.fire_shot(player1, player2)
      allow(player1).to receive(:client).and_return(i = IO.new(1))
      allow(i).to receive(:gets).and_return('A1')
      game.fire_shot(player1, player2)
      allow(player1).to receive(:client).and_return(i = IO.new(1))
      allow(i).to receive(:gets).and_return('E2')
      expect(game.fire_shot(player1, player2)).to eq('DESTROYER SANK!')
    end
  end

  describe '#end_game?' do
    it 'returns true when all ships from a player are destroyed' do
      allow(player2).to receive(:ships_coordinates).and_return({ submarine: ['A1', 'A2', 'A3'], destroyer: ['B2','E2']})
      allow(player1).to receive(:client).and_return(i = IO.new(1))
      allow(i).to receive(:gets).and_return('B2')
      game.fire_shot(player1, player2)
      allow(player1).to receive(:client).and_return(i = IO.new(1))
      allow(i).to receive(:gets).and_return('E2')
      game.fire_shot(player1, player2)
      expect(game.end_game?(player1, player2)).to be false
      allow(player1).to receive(:client).and_return(i = IO.new(1))
      allow(i).to receive(:gets).and_return('A1')
      game.fire_shot(player1, player2)
      allow(player1).to receive(:client).and_return(i = IO.new(1))
      allow(i).to receive(:gets).and_return('A2')
      game.fire_shot(player1, player2)
      allow(player1).to receive(:client).and_return(i = IO.new(1))
      allow(i).to receive(:gets).and_return('A3')
      game.fire_shot(player1, player2)
      expect(game.end_game?(player1, player2)).to be true
    end
  end
end
