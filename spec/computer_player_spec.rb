require 'computer_player'

describe ComputerPlayer do
  let(:client) {double :client}
  subject(:computer) {ComputerPlayer.new('Computer', client)}

  describe '#shots' do
    it 'declares shots'
  end

  describe '#ship_valid_coordinates' do
    it 'should read from terminal which ship to position'
    
    context 'when direction is vertical' do
      it 'creates random valid vertical coordinates for each ship' do
        coordinates = computer.ship_valid_coordinates('destroyer', 'vertical')
        expect(coordinates.split('')[1].to_i).to be <= 9
        coordinates = computer.ship_valid_coordinates('cruiser', 'vertical')
        expect(coordinates.split('')[1].to_i).to be <= 8
      end
    end

    context 'when direction is horizontal' do
      it 'creates random valid horizontal coordinates for each ship' do
        coordinates = computer.ship_valid_coordinates('destroyer', 'horizontal')
        expect(coordinates.split('').first.ord).to be <= 'I'.ord
        coordinates = computer.ship_valid_coordinates('cruiser', 'horizontal')
        expect(coordinates.split('').first.ord).to be <= 'H'.ord
      end
    end
  end
end
