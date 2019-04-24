require 'grid'

describe Grid do
  let(:coordinates) { { carrier: ['C5', 'C6', 'C7', 'C8', 'C9'], destroyer: ['I6', 'J6'] } }
  let(:printed_grid) do
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

  describe '#print_grid' do
    it 'prints player grid with ships' do
      expect(subject.print_grid(coordinates)).to eq printed_grid
    end
  end

  it 'prints opponent grid and player grid'
end
