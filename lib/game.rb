class Game

  attr_reader :coordinates
  SHIPS = {
    carrier: [1, 5],
    battleship: [2, 4],
    cruiser: [3, 3],
    submarine: [4, 3],
    destroyer: [5, 2]
  }

  def initialize
    @coordinates = Hash.new
  end
  def ships
    string = ''
    SHIPS.each do |ship, details|
      string += "#{ship.capitalize} Qty: #{details.first} Length: #{details.last}\n"
    end
    puts string
  end

  def position_ships
    puts 'To position your ships on the grid enter starting coordinates (A to J and 1 to 10) and vertical or horizontal.
EXAMPLE: B5 vertical'
  end

  def ships_coordinates(ship, coordinates)
    length = SHIPS[ship][1]
    coordinates = coordinates.split(' ')
    direction = coordinates.last
    start = coordinates.first.split('')
    start_horizontal = start.first
    start_vertical = start.last.to_i
    coordinates_array = Array.new
    if direction == 'vertical'
      length.times do |n|
        coordinates_array << "#{ start_horizontal }#{ start_vertical + n}"
      end
    else
      length.times do |n|
        coordinates_array << "#{ (start_horizontal.ord + n).chr}#{start_vertical}"
      end
    end
    @coordinates[ship] = coordinates_array
  end
end
