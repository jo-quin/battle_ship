require 'computer_player'

describe ComputerPlayer do
  let(:client) {double :client}
  subject(:computer) {ComputerPlayer.new('Computer', client)}

  describe '#input'do
    context 'should read from terminal to decide which method to run' do
      it 'should call ship_valid_coordinates when receiving "Carrier (5):"' do
        expect(computer).to receive(:ship_valid_coordinates)
        allow(client).to receive(:puts)
        computer.input('Carrier (5):')
      end

      it 'should call shots when receiving "Enter shot coordinate:"'
    end
  end

  describe '#shots' do
    it 'declares shots'
  end

  describe '#ship_valid_coordinates' do
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
