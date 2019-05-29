require 'computer_player'

describe ComputerPlayer do
  describe '#shots' do
    it 'declares shots'
  end

  describe '#ship_valid_coordinates' do
    it 'creates random valid horizontal coordinates for each ship' do
      coordinates = subject.ship_valid_coordinates('destroyer')
      expect(coordinates.split('').first.ord).to be <= 'I'.ord
      coordinates = subject.ship_valid_coordinates('cruiser')
      expect(coordinates.split('').first.ord).to be <= 'H'.ord
    end

    it 'creates random valid vertical coordinates for each ship' do
      coordinates = subject.ship_valid_coordinates('destroyer')
      expect(coordinates.split('')[1].to_i).to be <= 9
      coordinates = subject.ship_valid_coordinates('cruiser')
      expect(coordinates.split('')[1].to_i).to be <= 8
    end
  end
end
