require 'computer_player'

describe ComputerPlayer do
  subject(:computer) {ComputerPlayer.new()}

  describe '#input'do
    context 'should read from terminal to decide which method to run' do
      it 'should call the name attribute when receiving "Enter your name:"' do
        expect(computer.input('Enter your name: ')).to eq(computer.name)
      end
      it 'should call ship_valid_coordinates when receiving "Carrier (5):"' do
        expect(computer).to receive(:ship_valid_coordinates).with('carrier')
        computer.input('Carrier (5):')
      end

      it 'should remove one shot coordinate from shots when receiving "Enter shot coordinate:"' do
        expect{ computer.input('Enter shot coordinate: ') }.to change{ computer.shots.length }.by -1
      end
    end
  end

  describe '#shots' do
    it 'declares shots'
  end

  describe 'SHOT_OPTIONS' do
    context '#shot_option_1' do
      it 'should return last shot with letter up' do
        expect(computer.shot_option_1('B1')).to eq('C1')
      end
    end

    context '#shot_option_2' do
      it 'should return last shot with letter down' do
        expect(computer.shot_option_2('B1')).to eq('A1')
      end
    end

    context '#shot_option_3' do
      it 'should return last shot with number up' do
        expect(computer.shot_option_3('B2')).to eq('B3')
      end
    end

    context '#shot_option_4' do
      it 'should return last shot with number down' do
        expect(computer.shot_option_4('B2')).to eq('B1')
      end
    end
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
