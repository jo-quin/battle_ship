require_relative 'grid'

class Game
  attr_reader :ships_coordinates
  SHIPS = {
    carrier: 5,
    battleship: 4,
    cruiser: 3,
    submarine: 3,
    destroyer: 2
  }

  def initialize(grid = Grid.new, player1, player2)
    @player1 = player1
    @player2 = player2
    @grid = grid
  end

  def ships
    string = ''
    SHIPS.each do |ship, length|
      string += "#{ship.capitalize} Length: #{length}\n"
    end
    puts string
  end

  def position_ships_instructions
    puts 'To position your ships on the grid enter starting coordinates (A to J and 1 to 10) and vertical or horizontal.
EXAMPLE: B5 vertical'
  end

  def position_ships(player)
    SHIPS.each do |ship, length|
      puts @grid.print_grid(player.ships_coordinates)
      input_coordinates(ship, length, player)
    end
  end

  def play_screen(player)
    puts @grid.print_grid(player.shots_coordinates, 'X')
    puts 
    puts @grid.print_grid(player.ships_coordinates)
  end

  def fire_shot(player)
    puts 'Enter shot coordinate:'
    player.shots_coordinates[:shots] << gets.chomp
    player.shots_coordinates[:shots].uniq!
  end

  private

  def input_coordinates(ship, length, player)
    puts "#{ship.capitalize} (#{length}): "
    coordinates = gets.chomp
    save_ships_coordinates(ship, coordinates, player)
  end

  def split_coordinates(coordinates)
    coordinates = coordinates.split(' ')
    direction = coordinates.last
    start = coordinates.first.split('')
    start_horizontal = start.first
    start_vertical = start.last.to_i
    return direction, start_horizontal, start_vertical
  end

  def save_ships_coordinates(ship, coordinates, player)
    length = SHIPS[ship]
    direction, start_horizontal, start_vertical = split_coordinates(coordinates)
    coordinates_array = []
    if direction == 'vertical'
      length.times do |n|
        coordinates_array << "#{start_horizontal}#{start_vertical + n}"
      end
    else
      length.times do |n|
        coordinates_array << "#{(start_horizontal.ord + n).chr}#{start_vertical}"
      end
    end
    player.ships_coordinates[ship] = coordinates_array
  end
end
