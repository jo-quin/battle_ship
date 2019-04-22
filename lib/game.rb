class Game

  attr_reader :coordinates
  SHIPS = {
    carrier: 5,
    battleship: 4,
    cruiser: 3,
    submarine: 3,
    destroyer: 2
  }

  def initialize
    @coordinates = Hash.new
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

  def position_ships
    SHIPS.each do |ship, _value|
      input_coordinates(ship)
    end
  end

  def input_coordinates(ship)
    puts "#{ship.capitalize}: "
    coordinates = gets.chomp
    ships_coordinates(ship, coordinates)
  end

  def ships_coordinates(ship, coordinates)
    length = SHIPS[ship]
    coordinates = coordinates.split(' ')
    direction = coordinates.last
    start = coordinates.first.split('')
    start_horizontal = start.first
    start_vertical = start.last.to_i
    coordinates_array = Array.new
    if direction == 'vertical'
      length.times do |n|
        coordinates_array << "#{start_horizontal }#{start_vertical + n}"
      end
    else
      length.times do |n|
        coordinates_array << "#{(start_horizontal.ord + n).chr}#{start_vertical}"
      end
    end
    @coordinates[ship] = coordinates_array
  end
end
