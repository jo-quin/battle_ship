require 'player'

describe Player do
  subject(:player) { Player.new('Player1')}

  context 'when initialize' do
    it 'has player name' do
      expect(player.name).to eq 'Player1'
    end

    it 'has empty ships_coordinates' do
      expect(player.ships_coordinates).to be_empty
    end

    it 'has empty shots_coordinates' do
      expect(player.shots_coordinates).to eq({ shots: []})
    end
  end
end