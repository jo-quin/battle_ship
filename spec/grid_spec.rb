require 'grid'

describe Grid do
  let(:coordinates_ships) { { carrier: ['C5', 'C6', 'C7', 'C8', 'C9'], destroyer: ['I6', 'J6'] } }
  let(:coordinates_shot) { { shot: ['E5'] } }
  let(:printed_grid_ships) do
    '''  | A | B | C | D | E | F | G | H | I | J |
1 |   |   |   |   |   |   |   |   |   |   |
2 |   |   |   |   |   |   |   |   |   |   |
3 |   |   |   |   |   |   |   |   |   |   |
4 |   |   |   |   |   |   |   |   |   |   |
5 |   |   | 0 |   |   |   |   |   |   |   |
6 |   |   | 0 |   |   |   |   |   | 0 | 0 |
7 |   |   | 0 |   |   |   |   |   |   |   |
8 |   |   | 0 |   |   |   |   |   |   |   |
9 |   |   | 0 |   |   |   |   |   |   |   |
10|   |   |   |   |   |   |   |   |   |   |
'''
  end

  let(:printed_grid_shot) do
    '''  | A | B | C | D | E | F | G | H | I | J |
1 |   |   |   |   |   |   |   |   |   |   |
2 |   |   |   |   |   |   |   |   |   |   |
3 |   |   |   |   |   |   |   |   |   |   |
4 |   |   |   |   |   |   |   |   |   |   |
5 |   |   |   |   | X |   |   |   |   |   |
6 |   |   |   |   |   |   |   |   |   |   |
7 |   |   |   |   |   |   |   |   |   |   |
8 |   |   |   |   |   |   |   |   |   |   |
9 |   |   |   |   |   |   |   |   |   |   |
10|   |   |   |   |   |   |   |   |   |   |
'''
  end

  describe '#print_grid' do
    it 'prints player grid with ships' do
      expect(subject.print_grid(coordinates_ships)).to eq printed_grid_ships
    end

    it 'prints grid with shoots' do
      expect(subject.print_grid(coordinates_shot, 'X')).to eq printed_grid_shot
    end
  end
end
