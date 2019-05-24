require 'grid'

describe Grid do
  let(:coordinates_ships) { { carrier: ['C5', 'C6', 'C7', 'C8', 'C9'], destroyer: ['I6', 'J6'] } }
  let(:opponent_shots) { { hit: ['C6', 'C9', 'J6'], miss: ['F3', 'B10']}}
  let(:coordinates_shot) { { hit: ['A10'], miss: ['E5'] } }
  let(:printed_grid_ships) do
    """
   | A | B | C | D | E | F | G | H | I | J |
 1 |   |   |   |   |   |   |   |   |   |   |
 2 |   |   |   |   |   |   |   |   |   |   |
 3 |   |   |   |   |   | \e[36mX\e[0m |   |   |   |   |
 4 |   |   |   |   |   |   |   |   |   |   |
 5 |   |   | 0 |   |   |   |   |   |   |   |
 6 |   |   | \e[91mX\e[0m |   |   |   |   |   | 0 | \e[91mX\e[0m |
 7 |   |   | 0 |   |   |   |   |   |   |   |
 8 |   |   | 0 |   |   |   |   |   |   |   |
 9 |   |   | \e[91mX\e[0m |   |   |   |   |   |   |   |
 10|   | \e[36mX\e[0m |   |   |   |   |   |   |   |   |

"""
  end

  let(:printed_grid_shot) do
    """
   | A | B | C | D | E | F | G | H | I | J |
 1 |   |   |   |   |   |   |   |   |   |   |
 2 |   |   |   |   |   |   |   |   |   |   |
 3 |   |   |   |   |   |   |   |   |   |   |
 4 |   |   |   |   |   |   |   |   |   |   |
 5 |   |   |   |   | \e[36mX\e[0m |   |   |   |   |   |
 6 |   |   |   |   |   |   |   |   |   |   |
 7 |   |   |   |   |   |   |   |   |   |   |
 8 |   |   |   |   |   |   |   |   |   |   |
 9 |   |   |   |   |   |   |   |   |   |   |
 10| \e[91mX\e[0m |   |   |   |   |   |   |   |   |   |

"""
  end

  describe '#print_grid1' do
    it 'prints player grid with ships' do
      expect(subject.print_grid1(coordinates_ships, opponent_shots)).to eq printed_grid_ships
    end

    it 'prints grid with shoots' do
      expect(subject.print_grid2(coordinates_shot)).to eq printed_grid_shot
    end
  end
end
